import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../api/lecture_api.dart';
import '../login_screen.dart';
import 'package:provider/provider.dart';
import '../../api/lecture_api.dart';

class TimetableQ1 extends StatefulWidget {
  final TimeTableSurveyData data;
  final VoidCallback onCancel;
  final VoidCallback onNext;
  final void Function(TimeTableSurveyData) onChanged;
  const TimetableQ1(
      {Key? key,
      required this.data,
      required this.onCancel,
      required this.onNext,
      required this.onChanged})
      : super(key: key);

  @override
  State<TimetableQ1> createState() => _TimetableQ1State();
}

class _TimetableQ1State extends State<TimetableQ1> {
  late List<Map<String, String?>> selectedLectures;
  late TextEditingController _searchController;
  List<Map<String, dynamic>> _filteredLectures = [];

  @override
  void initState() {
    super.initState();
    selectedLectures = List<Map<String, String?>>.from(
        widget.data.preAppliedLectures.isNotEmpty
            ? widget.data.preAppliedLectures
            : []);
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchFocusOrChange);
  }

  void _onSearchFocusOrChange() {
    if (_searchFocusNode.hasFocus && _searchController.text.trim().isEmpty) {
      setState(() {
        _filteredLectures = _allLecturesWithCourseName(context)
            .where((lec) => !selectedLectures.any((sel) =>
                sel['id'] == lec['lecture'].id &&
                sel['classId'] == lec['lecture'].classId))
            .toList();
      });
    }
  }

  final FocusNode _searchFocusNode = FocusNode();

  void _updateLectureName(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        if (_searchFocusNode.hasFocus) {
          _filteredLectures = _allLecturesWithCourseName(context)
              .where((lec) => !selectedLectures.any((sel) =>
                  sel['id'] == lec['lecture'].id &&
                  sel['classId'] == lec['lecture'].classId))
              .toList();
        } else {
          _filteredLectures = [];
        }
      } else if (value.trim().length < 2) {
        _filteredLectures = [];
      } else {
        final query = value.trim().toLowerCase().replaceAll(' ', '');
        _filteredLectures = _allLecturesWithCourseName(context)
            .where((lec) => lec['courseName']
                .replaceAll(' ', '')
                .toLowerCase()
                .contains(query))
            .where((lec) => !selectedLectures.any((sel) =>
                sel['id'] == lec['lecture'].id &&
                sel['classId'] == lec['lecture'].classId))
            .toList();
      }
    });
  }

  void _selectLecture(Map<String, dynamic> lec) {
    setState(() {
      selectedLectures.add({
        'id': lec['lecture'].id,
        'name': '${lec['courseName']} - ${lec['lecture'].classId}분반',
        'classId': lec['lecture'].classId,
        'professor': lec['lecture'].professor,
        'time': lec['lecture'].time,
      });
      _searchController.clear();
      _filteredLectures = [];
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
      ..preAppliedLectures = List<Map<String, String?>>.from(selectedLectures));
  }

  List<Map<String, dynamic>> _allLecturesWithCourseName(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context, listen: false).courses;
    return courses
        .expand(
            (c) => c.lectures.map((l) => {'lecture': l, 'courseName': c.name}))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final sections = ['1분반', '2분반', '3분반', '4분반'];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 X + 프로그레스바 (10%)
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
                          widthFactor: 0.1, // 10%
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
                    '10%',
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
                'Q1',
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
                '사전 신청 된 강좌가 있나요?',
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
                '강의명만 입력하거나 강의+분반을 선택해주세요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0x6606003A),
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
                      _filteredLectures = _allLecturesWithCourseName(context)
                          .where((lec) => !selectedLectures.any((sel) =>
                              sel['id'] == lec['lecture'].id &&
                              sel['classId'] == lec['lecture'].classId))
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
                                        .isNotEmpty ||
                                    (selectedLectures[i]['time'] ?? '')
                                        .isNotEmpty)
                                  Text(
                                    '${selectedLectures[i]['professor'] ?? ''} · ${selectedLectures[i]['time'] ?? ''}',
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
            if (_filteredLectures.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    itemCount: _filteredLectures.length,
                    itemBuilder: (context, idx) {
                      final lec = _filteredLectures[idx];
                      return GestureDetector(
                        onTap: () => _selectLecture(lec),
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
                                '${lec['courseName']} - ${lec['lecture'].classId}분반',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color(0xFF06003A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${lec['lecture'].professor} · ${lec['lecture'].time}',
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
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06003A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
