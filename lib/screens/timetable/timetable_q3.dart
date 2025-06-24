import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'timetable_q2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../api/lecture_api.dart';
import '../login_screen.dart';
import 'package:provider/provider.dart';
import '../../api/lecture_api.dart';

class TimetableQ3 extends StatefulWidget {
  final TimeTableSurveyData data;
  final VoidCallback onCancel;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final void Function(TimeTableSurveyData) onChanged;
  const TimetableQ3({
    Key? key,
    required this.data,
    required this.onCancel,
    required this.onPrev,
    required this.onNext,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimetableQ3> createState() => _TimetableQ3State();
}

class _TimetableQ3State extends State<TimetableQ3> {
  late List<Map<String, String?>> selectedLectures;
  late TextEditingController _searchController;
  final List<Lecture> _filteredLectures = [];

  @override
  void initState() {
    super.initState();
    selectedLectures = widget.data.mustLectures.isNotEmpty
        ? List<Map<String, String?>>.from(widget.data.mustLectures)
        : [];
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchFocusOrChange);
  }

  List<Map<String, String>> _uniqueSubjects(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context, listen: false).courses;
    final seen = <String>{};
    final result = <Map<String, String>>[];
    for (final course in courses) {
      for (final lec in course.lectures) {
        final key = '${course.name}__${lec.professor}';
        if (!seen.contains(key)) {
          seen.add(key);
          result.add({'name': course.name, 'professor': lec.professor});
        }
      }
    }
    return result;
  }

  void _onSearchFocusOrChange() {
    if (_searchFocusNode.hasFocus && _searchController.text.trim().isEmpty) {
      setState(() {
        _filteredSubjects = _uniqueSubjects(context)
            .where((subj) => !selectedLectures.any((sel) =>
                sel['name'] == subj['name'] &&
                sel['professor'] == subj['professor']))
            .toList();
      });
    }
  }

  final FocusNode _searchFocusNode = FocusNode();

  List<Map<String, String>> _filteredSubjects = [];

  void _updateLectureName(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        if (_searchFocusNode.hasFocus) {
          _filteredSubjects = _uniqueSubjects(context)
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
        _filteredSubjects = _uniqueSubjects(context)
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

  void _selectLecture(Map<String, String> subj) {
    setState(() {
      selectedLectures.add({
        'name': subj['name'] ?? '',
        'professor': subj['professor'] ?? '',
      });
      _searchController.clear();
      _filteredSubjects = [];
      _notifyChange();
    });
  }

  void _removeLecture(int idx) {
    setState(() {
      selectedLectures.removeAt(idx);
      _notifyChange();
    });
  }

  void _notifyChange() {
    widget.onChanged(widget.data
      ..mustLectures = List<Map<String, String?>>.from(selectedLectures));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 X + 프로그레스바 (30%)
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
                          widthFactor: 0.3, // 30%
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
                    '30%',
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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                'Q3',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF7B7684),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Text(
                '꼭 들어야 하는 과목이 있나요?',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
              child: Text(
                '강의명만 입력하거나 강의+교수를 선택해주세요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0x997B7684),
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
                      _filteredSubjects = _uniqueSubjects(context)
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
                              const SizedBox(height: 2),
                              Text(
                                subj['professor'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xFFB6B1C2),
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
