import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'timetable_q2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimetableQ6to9 extends StatelessWidget {
  final String question;
  final List<String> options;
  final double progress; // 0~1
  final int value;
  final void Function(int) onChanged;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  const TimetableQ6to9({
    super.key,
    required this.question,
    required this.options,
    required this.progress,
    required this.value,
    required this.onChanged,
    required this.onPrev,
    required this.onNext,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 X + 프로그레스바
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onCancel,
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
                          widthFactor: progress,
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
                  Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
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
            // Q6~Q9 텍스트(상단)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                'Q${(progress * 10).round()}',
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF9B98AC),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Text(
                question,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
                options.length,
                (i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: GestureDetector(
                        onTap: () => onChanged(i),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: value == i
                                      ? const Color(0xFF6178FA)
                                      : const Color(0xFFD9D7E0),
                                  width: 2,
                                ),
                                color: value == i
                                    ? const Color(0xFF6178FA)
                                    : Colors.white,
                              ),
                              child: value == i
                                  ? const Icon(Icons.circle,
                                      size: 14, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              options[i],
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.4,
                                color: value == i
                                    ? const Color(0xFF06003A)
                                    : const Color(0xFFB6B1C2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TimetableQ2ButtonBar(
                onPrev: onPrev,
                onNext: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
