import 'package:flutter/material.dart';

class ReviewDetailHeader extends StatelessWidget {
  const ReviewDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목 + 분반 한 줄
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF06003A),
            ),
            children: [
              TextSpan(text: '그래픽디자인1'),
              TextSpan(
                text: '  001',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(6, 0, 58, 0.3),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '심땡땡 교수님',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color.fromRGBO(6, 0, 58, 0.6),
          ),
        ),
      ],
    );
  }
}
