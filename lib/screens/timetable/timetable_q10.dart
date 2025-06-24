import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'timetable_q2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimetableQ10 extends StatefulWidget {
  final TimeTableSurveyData data;
  final VoidCallback onCancel;
  final VoidCallback onPrev;
  final VoidCallback onFinish;
  final void Function(TimeTableSurveyData) onChanged;
  const TimetableQ10({
    Key? key,
    required this.data,
    required this.onCancel,
    required this.onPrev,
    required this.onFinish,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimetableQ10> createState() => _TimetableQ10State();
}

class _TimetableQ10State extends State<TimetableQ10> {
  late List<String> professors;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    professors = List<String>.from(widget.data.preferredProfessors ?? []);
  }

  void _addProfessor(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      professors.add(trimmed);
      _controller.clear();
      _notifyChange();
    });
  }

  void _removeProfessor(int idx) {
    setState(() {
      professors.removeAt(idx);
      _notifyChange();
    });
  }

  void _notifyChange() {
    widget.onChanged(
        widget.data..preferredProfessors = List<String>.from(professors));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 X + 프로그레스바 (100%)
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
                          widthFactor: 1.0, // 100%
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
                    '100%',
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
                'Q10',
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
                '선호하는 교수님이 있다면 입력해주세요',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F3),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '교수님을 입력하세요',
                        hintStyle: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFFB6B1C2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: _addProfessor,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(
                          professors.length,
                          (idx) => Chip(
                                label: Text(
                                  professors[idx],
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: const Color(0xFF6178FA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                deleteIcon: const Icon(Icons.close,
                                    size: 18, color: Colors.white),
                                onDeleted: () => _removeProfessor(idx),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                              )),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // 완료 버튼 항상 노출
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TimetableQ2ButtonBar(
                onPrev: widget.onPrev,
                onNext: widget.onFinish,
                nextLabel: '테스트 완료',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
