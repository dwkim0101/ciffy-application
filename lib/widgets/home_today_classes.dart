import 'package:flutter/material.dart';

class HomeTodayClasses extends StatelessWidget {
  const HomeTodayClasses({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      {'title': '스마트UX&UI디자인1', 'prof': '이지은 교수님', 'room': '집401'},
      {'title': '인포그래픽', 'prof': '양땡땡 교수님', 'room': '집402'},
    ];
    return Column(
      children: List.generate(classes.length, (i) {
        final c = classes[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4, right: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF6178FA),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title']!,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFFF1F2F8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          c['prof']!,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            color: Color(0xFFF1F2F8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          c['room']!,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            color: Color(0xFFF1F2F8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
