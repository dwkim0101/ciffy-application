import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import '../api/secure_storage.dart';
import 'login_screen.dart';
import '../api/user_api.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await SecureStorage.deleteToken();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 상태바(시스템 네비게이션 바) 색상 항상 검정색으로 고정
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 배경 투명
      statusBarIconBrightness: Brightness.dark, // 아이콘 검정
      statusBarBrightness: Brightness.light, // iOS용
    ));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // 상단 타이틀
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '마이페이지',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF06003A),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 프로필 이미지
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFF1F2F8),
                child: SvgPicture.asset(
                  'assets/block_character.svg',
                  width: 110,
                  height: 110,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 이름
            Text(
              UserStore.user?.name ?? '-',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xFF06003A),
              ),
            ),
            const SizedBox(height: 32),
            // 정보 카드
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: [
                    _infoRow('학과', UserStore.user?.major ?? '-'),
                    const SizedBox(height: 8),
                    _infoRow('학번', UserStore.user?.studentId ?? '-'),
                    const SizedBox(height: 8),
                    _infoRow('학년', UserStore.user?.grade.toString() ?? '-'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 수강한 과목
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          '수강한 과목',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF06003A),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child:
                            Icon(Icons.chevron_right, color: Color(0xFF06003A)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 로그아웃
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => _logout(context),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFFD93434),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // 계정 삭제
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      '계정 삭제',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFFD93434),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget _infoRow(String label, String value) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color.fromRGBO(6, 0, 58, 0.4),
        ),
      ),
      const SizedBox(width: 32),
      Text(
        value,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF06003A),
        ),
      ),
    ],
  );
}
