import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'timetable_q2.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  late List<Map<String, String?>> lectures;

  @override
  void initState() {
    super.initState();
    final wishLectures = (widget.data.majorWishLectures is List)
        ? widget.data.majorWishLectures
        : [];
    lectures = List<Map<String, String?>>.from(
      (wishLectures.isNotEmpty)
          ? wishLectures
          : [
              {'name': '', 'professor': null}
            ],
    );
  }

  void _addLecture() {
    setState(() {
      lectures.add({'name': '', 'professor': null});
      _notifyChange();
    });
  }

  void _updateLectureName(int idx, String value) {
    setState(() {
      lectures[idx]['name'] = value;
      _notifyChange();
    });
  }

  void _updateLectureProfessor(int idx, String? value) {
    setState(() {
      lectures[idx]['professor'] = value;
      _notifyChange();
    });
  }

  void _notifyChange() {
    widget.onChanged(widget.data
      ..majorWishLectures = List<Map<String, String?>>.from(lectures));
  }

  @override
  Widget build(BuildContext context) {
    final professors = ['교수A', '교수B', '교수C', '교수D'];
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
                                '교수님',
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
                                  value: lecture['professor'],
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('선택',
                                          style: TextStyle(
                                              color: Color(0xFFB6B1C2))),
                                    ),
                                    ...professors.map((s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        )),
                                  ],
                                  onChanged: (v) =>
                                      _updateLectureProfessor(idx, v),
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
                                  color: Color(0xFF6178FA), size: 20),
                              SizedBox(width: 4),
                              Text(
                                '강의 추가',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF6178FA),
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
