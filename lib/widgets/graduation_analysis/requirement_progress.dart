import 'package:flutter/material.dart';

class RequirementProgress extends StatelessWidget {
  const RequirementProgress({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final areas = [
      {'name': '교양', 'progress': 0.8},
      {'name': '전공', 'progress': 0.65},
      {'name': '선택', 'progress': 0.5},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '영역별 이수 현황',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF06003A),
          ),
        ),
        const SizedBox(height: 16),
        ...areas.map((area) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      area['name'] as String,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF8886A3),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: area['progress'] as double,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFF1F2F8),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF06003A)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${((area['progress'] as double) * 100).round()}%',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF06003A),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
