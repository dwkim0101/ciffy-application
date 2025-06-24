import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimetableTestComplete extends StatefulWidget {
  final VoidCallback onComplete;
  const TimetableTestComplete({Key? key, required this.onComplete})
      : super(key: key);

  @override
  State<TimetableTestComplete> createState() => _TimetableTestCompleteState();
}

class _TimetableTestCompleteState extends State<TimetableTestComplete> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/block_character.svg',
                  width: 110,
                  height: 110,
                ),
                const SizedBox(height: 48),
                const Text(
                  '테스트가 완료되었어요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 1.4,
                    color: Color(0xFF160095),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                const Text(
                  '테스트를 바탕으로 시간표를 짜고 있어요.\n조금만 기다려주세요!',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.4,
                    color: Color.fromRGBO(6, 0, 58, 0.3),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
