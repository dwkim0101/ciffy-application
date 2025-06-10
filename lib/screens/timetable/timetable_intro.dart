import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimetableIntro extends StatelessWidget {
  final VoidCallback onStartSurvey;
  const TimetableIntro({Key? key, required this.onStartSurvey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 140),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/block_character.svg',
                          width: 110,
                          height: 110,
                        ),
                        const SizedBox(height: 48),
                        const Text(
                          '나에게 최적의 시간표는 뭘까?',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.4,
                            color: Color(0xFF160095),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          '시간표를 짜기 전 10문항의 테스트로\n최적의 조건을 찾아봐요',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.4,
                            color: Color.fromRGBO(6, 0, 58, 0.4),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: onStartSurvey,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF06003A),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                '테스트 시작하기',
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
          ],
        ),
      ),
    );
  }
}
