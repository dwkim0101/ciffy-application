import 'package:flutter/material.dart';
import '../../screens/review_screen.dart';

class HomeReviewSection extends StatelessWidget {
  const HomeReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'title': '스마트UX&UI디자인1',
        'prof': '정수영 교수님',
        'content': '수업이 체계적이고 실습이 많아요!',
        'code': '001'
      },
      {
        'title': '인포그래픽',
        'prof': '양땡땡 교수님',
        'content': '실무에 바로 쓸 수 있는 팁이 많아요.',
        'code': '001'
      },
      {
        'title': '인포그래픽',
        'prof': '양땡땡 교수님',
        'content': '실무에 바로 쓸 수 있는 팁이 많아요.',
        'code': '001'
      },
      {
        'title': '인포그래픽',
        'prof': '양땡땡 교수님',
        'content': '실무에 바로 쓸 수 있는 팁이 많아요.',
        'code': '001'
      },
      {
        'title': '인포그래픽',
        'prof': '양땡땡 교수님',
        'content': '실무에 바로 쓸 수 있는 팁이 많아요.',
        'code': '001'
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReviewScreen()),
            );
          },
          child: const Row(
            children: [
              Text(
                '강의 후기',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 24, color: Color(0xFF06003A)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '수강생들의 솔직한 강의 후기를 확인하세요',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0x4D06003A), // 30% opacity
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(reviews.length, (i) {
            final r = reviews[i];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                border: Border.all(color: const Color(0xFFF1F2F8), width: 1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            r['title']!,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF06003A),
                            ),
                          ),
                          if ((r['code'] ?? '').isNotEmpty)
                            Text(
                              r['code']!,
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFFB6B0C3),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        r['prof']!,
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFFB6B0C3),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
