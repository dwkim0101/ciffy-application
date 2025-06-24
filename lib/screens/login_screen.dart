import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../widgets/bottom_bar.dart';
import '../api/auth_api.dart';
import '../api/secure_storage.dart';
import '../api/lecture_api.dart';

class LectureStore {
  static List<Map<String, dynamic>> lectures = [];
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool _isSaved = false;

  bool get _isFormValid =>
      _idController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    _btnController.start();
    final token = await AuthApi.login(
      id: _idController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (token != null) {
      await SecureStorage.saveToken(token);
      // 강의 목록 불러오기
      final lectures = await LectureApi.fetchLectures();
      LectureStore.lectures = lectures;
      _btnController.success();
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
        );
      }
    } else {
      _btnController.error();
      await Future.delayed(const Duration(seconds: 1));
      _btnController.reset();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인에 실패했습니다. 아이디/비밀번호를 확인하세요.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                '로그인',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Color(0xFF06003A),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _isSaved,
                        onChanged: (value) {
                          setState(() {
                            _isSaved = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF160095),
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(
                          color: _isSaved
                              ? const Color(0xFF160095)
                              : const Color(0xFFB6B0C3),
                          width: 1.5,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
                  Text(
                    '정보 저장하기',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: RoundedLoadingButton(
                  controller: _btnController,
                  color: const Color(0xFF06003A),
                  successColor: Colors.green,
                  errorColor: Colors.red,
                  borderRadius: 12,
                  onPressed: _isFormValid ? _onLogin : null,
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
