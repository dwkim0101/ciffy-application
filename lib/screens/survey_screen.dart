import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final int _currentIndex = 0;
  int? _selectedOption;

  // 예시 질문/선택지
  final List<Map<String, dynamic>> _questions = [
    {
      'question': '아침 수업이 편한가요?',
      'options': ['매우 그렇다', '그렇다', '보통이다', '아니다', '전혀 아니다'],
    },
    // 추가 질문 가능
  ];

  void _onSelect(int idx) {
    setState(() {
      _selectedOption = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentIndex];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 진행률
            Text(
              '${_currentIndex + 1} / ${_questions.length}',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF888696),
              ),
            ),
            const SizedBox(height: 24),
            // 질문
            Text(
              q['question'],
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF06003A),
              ),
            ),
            const SizedBox(height: 32),
            // 선택지
            ...List.generate(q['options'].length, (idx) {
              final selected = _selectedOption == idx;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () => _onSelect(idx),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF06003A) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF06003A)
                            : const Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      q['options'][idx],
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color:
                            selected ? Colors.white : const Color(0xFF06003A),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
