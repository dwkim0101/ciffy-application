import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';

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
                    child: const Icon(Icons.close,
                        size: 28, color: Color(0xFF06003A)),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                question,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
                options.length,
                (i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 6),
                      child: GestureDetector(
                        onTap: () => onChanged(i),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
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
                                      size: 12, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              options[i],
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: value == i
                                    ? const Color(0xFF6178FA)
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
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: onPrev,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC8C6D1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          '이전',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF06003A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
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
          ],
        ),
      ),
    );
  }
}
