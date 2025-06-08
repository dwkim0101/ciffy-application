import 'package:flutter/material.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    // 나중에 API에서 받아올 수업 개수
    const int classCount = 3;
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          height: 1.3,
          color: Color(0xFF06003A),
        ),
        children: [
          TextSpan(text: '김시피님 반가워요!\n'),
          TextSpan(
            children: [
              TextSpan(text: '오늘은 '),
              TextSpan(
                text: '$classCount개',
                style: TextStyle(
                  color: Color(0xFF4577FA), // Figma 기준 파란색
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: '의 수업이 있어요'),
            ],
          ),
        ],
      ),
    );
  }
}
