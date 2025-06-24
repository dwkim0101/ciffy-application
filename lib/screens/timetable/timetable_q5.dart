import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'timetable_q2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../api/lecture_api.dart';
import '../login_screen.dart';
import 'package:provider/provider.dart';
import '../../api/lecture_api.dart';

class TimetableQ5 extends StatefulWidget {
  final TimeTableSurveyData data;
  final VoidCallback onCancel;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final void Function(TimeTableSurveyData) onChanged;
  const TimetableQ5({
    Key? key,
    required this.data,
    required this.onCancel,
    required this.onPrev,
    required this.onNext,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimetableQ5> createState() => _TimetableQ5State();
}

class _TimetableQ5State extends State<TimetableQ5> {
  late List<Map<String, String?>> selectedLectures;
  late TextEditingController _searchController;
  List<Map<String, String>> _filteredSubjects = [];
  final String _selectedProfessor = '전체';

  @override
  void initState() {
    super.initState();
    final wishLectures = (widget.data.majorWishLectures is List)
        ? widget.data.majorWishLectures
        : [];
    selectedLectures = (wishLectures.isNotEmpty)
        ? List<Map<String, String?>>.from(wishLectures)
        : [];
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchFocusOrChange);
  }

  List<Map<String, String>> _uniqueMajorSubjects(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context, listen: false).courses;
    final major = UserStore.user?.major ?? '';
    final seen = <String>{};
    final result = <Map<String, String>>[];
    for (final course in courses) {
      if ((course.type == '전공필수' || course.type == '전공선택') &&
          course.mandatory == major) {
        if (!seen.contains(course.name)) {
          seen.add(course.name);
          result.add({'name': course.name});
        }
      }
    }
    return result;
  }

  void _onSearchFocusOrChange() {
    if (_searchFocusNode.hasFocus && _searchController.text.trim().isEmpty) {
      setState(() {
        _filteredSubjects = _uniqueMajorSubjects(context)
            .where((subj) => !selectedLectures.any((sel) =>
                sel['name'] == subj['name'] &&
                sel['professor'] == subj['professor']))
            .toList();
      });
    }
  }

  final FocusNode _searchFocusNode = FocusNode();

  void _updateLectureName(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        if (_searchFocusNode.hasFocus) {
          _filteredSubjects = _uniqueMajorSubjects(context)
              .where((subj) => !selectedLectures.any((sel) =>
                  sel['name'] == subj['name'] &&
                  sel['professor'] == subj['professor']))
              .toList();
        } else {
          _filteredSubjects = [];
        }
      } else if (value.trim().length < 2) {
        _filteredSubjects = [];
      } else {
        final query = value.trim().toLowerCase().replaceAll(' ', '');
        _filteredSubjects = _uniqueMajorSubjects(context)
            .where((subj) => (subj['name'] ?? '')
                .replaceAll(' ', '')
                .toLowerCase()
                .contains(query))
            .where((subj) => !selectedLectures.any((sel) =>
                sel['name'] == subj['name'] &&
                sel['professor'] == subj['professor']))
            .toList();
      }
    });
  }

  void _selectLecture(Map<String, String> subj) async {
    // 과목명 클릭 시 교수명 리스트 모달 노출
    final courses = Provider.of<CourseProvider>(context, listen: false).courses;
    final course = courses.firstWhere((c) => c.name == subj['name']);
    final professors = course.lectures.map((l) => l.professor).toSet().toList();
    final selectedProfessor = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '교수님을 선택하세요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...professors.map((prof) => ListTile(
                  title: Text(prof),
                  onTap: () => Navigator.pop(context, prof),
                )),
            const SizedBox(height: 16),
          ],
        );
      },
    );
    if (selectedProfessor != null && selectedProfessor.isNotEmpty) {
      setState(() {
        selectedLectures.add({
          'name': subj['name'] ?? '',
          'professor': selectedProfessor,
        });
        _searchController.clear();
        _filteredSubjects = [];
        _notifyChange();
      });
    }
  }

  void _removeLecture(int idx) {
    setState(() {
      selectedLectures.removeAt(idx);
      _notifyChange();
    });
  }

  void _notifyChange() {
    widget.onChanged(widget.data
      ..majorWishLectures = List<Map<String, String?>>.from(selectedLectures));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 X + 프로그레스바 (50%)
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.onCancel,
                    child: SvgPicture.asset(
                      'assets/cancel.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0x1A06003A),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.5, // 50%
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF06003A),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '50%',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0x4D000000),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                'Q5',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF9B98AC),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Text(
                '희망하는 전공 과목을 골라주세요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: _updateLectureName,
                onTap: () {
                  if (_searchController.text.trim().isEmpty) {
                    setState(() {
                      _filteredSubjects = _uniqueMajorSubjects(context)
                          .where((subj) => !selectedLectures.any((sel) =>
                              sel['name'] == subj['name'] &&
                              sel['professor'] == subj['professor']))
                          .toList();
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: '강의명 또는 강의명-분반을 입력하세요',
                  hintStyle: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFFB6B1C2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 선택된 강의 카드 리스트
            if (selectedLectures.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (int i = 0; i < selectedLectures.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedLectures[i]['name'] ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Color(0xFF06003A),
                                  ),
                                ),
                                if ((selectedLectures[i]['professor'] ?? '')
                                    .isNotEmpty)
                                  Text(
                                    selectedLectures[i]['professor'] ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Color(0xFFB6B1C2),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => _removeLecture(i),
                              child: const Icon(Icons.close,
                                  size: 18, color: Color(0xFFB6B1C2)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            // 검색 결과 카드 리스트
            if (_filteredSubjects.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    itemCount: _filteredSubjects.length,
                    itemBuilder: (context, idx) {
                      final subj = _filteredSubjects[idx];
                      return GestureDetector(
                        onTap: () => _selectLecture(subj),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subj['name'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color(0xFF06003A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TimetableQ2ButtonBar(
                onPrev: widget.onPrev,
                onNext: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
