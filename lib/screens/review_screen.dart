import 'package:flutter/material.dart';
import '../widgets/review/review_card.dart';
import 'review_detail_screen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final reviews = [
      {
        'title': '스마트UX&UI디자인1',
        'code': '002',
        'prof': '정수영 교수님',
      },
      {
        'title': '인포그래픽',
        'code': '001',
        'prof': '정땡땡 교수님',
      },
      {
        'title': '그래픽디자인1',
        'code': '002',
        'prof': '심땡땡 교수님',
      },
      {
        'title': '강의명',
        'code': '001',
        'prof': '정땡땡 교수님',
      },
      {
        'title': '강의명',
        'code': '002',
        'prof': '심땡땡 교수님',
      },
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF06003A), size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '강의후기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF06003A),
                    ),
                  ),
                ],
              ),
            ),
            // 검색창
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: const Color.fromRGBO(6, 0, 58, 0.1)),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF06003A),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '강의명 또는 교수님을 입력하세요',
                          hintStyle: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(6, 0, 58, 0.3),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Color(0xFFB6B0C3), size: 22),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            // 내 강의 + 정렬
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 강의',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF06003A),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '많이 담은 순',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color.fromRGBO(6, 0, 58, 0.6),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.keyboard_arrow_down_rounded,
                          size: 20, color: Color.fromRGBO(6, 0, 58, 0.6)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 카드 리스트
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: reviews.length,
                itemBuilder: (context, idx) {
                  final r = reviews[idx];
                  return ReviewCard(
                    title: r['title']!,
                    code: r['code']!,
                    prof: r['prof']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ReviewDetailScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
