import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/Logo.svg'),
                  const SizedBox(height: 12),
                  const Text(
                    '시피와 시간표짜기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      color: Color(0xFF06003A),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: null,
            bottom: 0,
            child: SafeArea(
              minimum: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.88,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06003A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '시피 시작하기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
