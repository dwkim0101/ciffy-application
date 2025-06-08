import 'package:flutter/material.dart';

class HomeReviewSection extends StatelessWidget {
  const HomeReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'title': '스마트UX&UI디자인1',
        'prof': '정수영 교수님',
        'content': '수업이 체계적이고 실습이 많아요!'
      },
      {'title': '인포그래픽', 'prof': '양땡땡 교수님', 'content': '실무에 바로 쓸 수 있는 팁이 많아요.'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '강의 후기',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF06003A),
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
        const SizedBox(height: 16),
        Column(
          children: List.generate(reviews.length, (i) {
            final r = reviews[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 4),
                    Text(
                      r['prof']!,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF888696),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      r['content']!,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF06003A),
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
