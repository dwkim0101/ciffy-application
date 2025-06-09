import 'package:flutter/material.dart';

class RequirementList extends StatelessWidget {
  const RequirementList({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final areas = [
      {
        'name': '교양',
        'completed': ['글쓰기', '영어', '컴퓨터'],
        'remaining': ['수학', '과학'],
      },
      {
        'name': '전공',
        'completed': ['전공기초', '전공필수'],
        'remaining': ['전공선택'],
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '영역별 상세',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF06003A),
          ),
        ),
        const SizedBox(height: 16),
        ...areas.map((area) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area['name'] as String,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF06003A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '이수',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFF8886A3),
                                ),
                              ),
                              ...List.generate(
                                (area['completed'] as List).length,
                                (i) => Text(
                                  (area['completed'] as List)[i] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xFF06003A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '미이수',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFF8886A3),
                                ),
                              ),
                              ...List.generate(
                                (area['remaining'] as List).length,
                                (i) => Text(
                                  (area['remaining'] as List)[i] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xFFB6B0C3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
