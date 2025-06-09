import 'package:flutter/material.dart';

class ReviewDetailComment extends StatelessWidget {
  const ReviewDetailComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        border: Border.all(color: const Color(0xFFF1F2F8), width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 별점
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFBF00), size: 20),
                    Icon(Icons.star, color: Color(0xFFFFBF00), size: 20),
                    Icon(Icons.star, color: Color(0xFFFFBF00), size: 20),
                    Icon(Icons.star, color: Color(0xFFFFBF00), size: 20),
                    Icon(Icons.star, color: Color(0xFFE6E6E6), size: 20),
                  ],
                ),
                Spacer(),
                Text(
                  '23년 1학기 수강자',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color.fromRGBO(6, 0, 58, 0.3),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              '소녀더러 병이 좀 낫거들랑 이사 가기 전에 한 번 개울가로 나와 달라는 말을 못 해 둔 것이었다. 소녀의 흰 얼굴이, 분홍 스웨터가, 남색 스커트가, 안고 있는 꽃과 함께 범벅이 된다. 그 말에는 대꾸도 없이, 아버지는 안고 있는 닭의 무게를 겨냥해 보면서, 이만하면 될까. 어머니가 망태기를 내주며, 벌써 며칠째 갈갈 하고 알 낳 자리를 보던데요.',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF06003A),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
