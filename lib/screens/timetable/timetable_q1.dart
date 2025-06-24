import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  late List<Map<String, String?>> lectures;

  @override
  void initState() {
    super.initState();
    lectures = List<Map<String, String?>>.from(
        widget.data.preAppliedLectures.isNotEmpty
            ? widget.data.preAppliedLectures
            : [
                {'name': '', 'section': null}
              ]);
  }

  void _addLecture() {
    setState(() {
      lectures.add({'name': '', 'section': null});
      _notifyChange();
    });
  }

  void _updateLectureName(int idx, String value) {
    setState(() {
      lectures[idx]['name'] = value;
      _notifyChange();
    });
  }

  void _updateLectureSection(int idx, String? value) {
    setState(() {
      lectures[idx]['section'] = value;
      _notifyChange();
    });
  }

  void _notifyChange() {
    widget.onChanged(widget.data
      ..preAppliedLectures = List<Map<String, String?>>.from(lectures));
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '강의명',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF7B7684),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '분반',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF7B7684),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...lectures.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final lecture = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '강의명을 입력하세요',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFFB6B1C2),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (v) => _updateLectureName(idx, v),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: lecture['section'],
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('선택',
                                          style: TextStyle(
                                              color: Color(0xFFB6B1C2))),
                                    ),
                                    ...sections.map((s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        )),
                                  ],
                                  onChanged: (v) =>
                                      _updateLectureSection(idx, v),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: _addLecture,
                          child: const Row(
                            children: [
                              Icon(Icons.add,
                                  color: Color(0xFF160095), size: 20),
                              SizedBox(width: 4),
                              Text(
                                '강의 추가',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF160095),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
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
