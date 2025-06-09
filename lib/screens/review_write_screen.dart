import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewWriteScreen extends StatelessWidget {
  const ReviewWriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF5F3F1),
      body: SafeArea(
        child: ReviewWriteScreenForm(),
      ),
    );
  }
}

class ReviewWriteScreenForm extends StatefulWidget {
  const ReviewWriteScreenForm({super.key});
  @override
  State<ReviewWriteScreenForm> createState() => _ReviewWriteScreenFormState();
}

class _ReviewWriteScreenFormState extends State<ReviewWriteScreenForm> {
  String selectedSemester = '';
  int selectedStar = 0;
  int task = -1;
  int group = -1;
  int grade = -1;
  final TextEditingController _controller = TextEditingController();

  final semesters = [
    '24년 2학기',
    '24년 1학기',
    '23년 2학기',
    '23년 1학기',
    '22년 2학기',
    '22년 1학기',
    '21년 2학기'
  ];
  final taskLabels = ['없음', '보통', '많음'];
  final groupLabels = ['없음', '보통', '많음'];
  final gradeLabels = ['너그러움', '보통', '깐깐함'];

  bool get isFormValid {
    return selectedSemester.isNotEmpty &&
        selectedStar > 0 &&
        task != -1 &&
        group != -1 &&
        grade != -1 &&
        _controller.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Container(
            height: 56,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(6, 0, 58, 0.3),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    '강의후기 작성하기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF06003A),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: isFormValid ? () {} : null,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '완료',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isFormValid
                            ? const Color(0xFF6178FA)
                            : const Color(0x806178FA),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 안내문구 박스 Figma 기준 수정
          Container(
            margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6FA), // Figma 기준 색상
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('어떤 점이 좋았는지, 아쉬웠는지 구체적인 내용을 작성해주세요.'),
                _bullet('강의와 관련 없는 내용은 삼가주세요.'),
                _bullet('비방, 욕설, 차별적 표현은 금지됩니다.'),
                _bullet('개인정보는 작성하지 마세요.'),
              ],
            ),
          ),
          // 강의 정보
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('강의명',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF06003A))),
                    SizedBox(height: 8),
                    Text('교수님',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF06003A))),
                    SizedBox(height: 8),
                    Text('분반',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF06003A))),
                  ],
                ),
                SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('그래픽디자인1',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF6178FA))),
                    SizedBox(height: 8),
                    Text('심땡땡',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF6178FA))),
                    SizedBox(height: 8),
                    Text('001',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF6178FA))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // 학기 드롭다운
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('학기',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF06003A))),
                const SizedBox(height: 8),
                _CustomDropdown(
                  value: selectedSemester,
                  hint: '학기를 선택해주세요',
                  items: semesters,
                  onChanged: (v) => setState(() => selectedSemester = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // 별점
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('별점',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF06003A))),
                const SizedBox(width: 16),
                ...List.generate(
                    5,
                    (i) => GestureDetector(
                          onTap: () => setState(() => selectedStar = i + 1),
                          child: Icon(
                            Icons.star,
                            size: 31,
                            color: i < selectedStar
                                ? const Color(0xFFFFBF00)
                                : const Color(0xFFE9E7E8),
                          ),
                        )),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // 카테고리: 과제/조모임/성적
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _categoryRadio(
                    '과제', task, taskLabels, (v) => setState(() => task = v)),
                const SizedBox(height: 16),
                _categoryRadio('조모임', group, groupLabels,
                    (v) => setState(() => group = v)),
                const SizedBox(height: 16),
                _categoryRadio(
                    '성적', grade, gradeLabels, (v) => setState(() => grade = v)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // 후기 입력
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('후기',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF06003A))),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFE9E7E8)),
                  ),
                  child: TextField(
                    controller: _controller,
                    minLines: 5,
                    maxLines: 8,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF06003A),
                        height: 1.4),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      hintText: '',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 7, right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF06003A), // 진한 남색
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF06003A),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryRadio(String label, int selected, List<String> options,
      void Function(int) onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 56,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF06003A),
            ),
          ),
        ),
        ...List.generate(
            options.length,
            (i) => Row(
                  children: [
                    _CustomRadio(
                      selected: selected == i,
                      onTap: () => onChanged(i),
                    ),
                    Text(
                      options[i],
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: selected == i
                            ? const Color(0xFF6178FA)
                            : const Color(0xFFB6B0C3),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                )),
      ],
    );
  }
}

class _CustomRadio extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  const _CustomRadio({required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? const Color(0xFF6178FA) : const Color(0xFFE9E7E8),
            width: 2,
          ),
        ),
        child: selected
            ? Center(
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6178FA),
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String> onChanged;
  const _CustomDropdown(
      {required this.value,
      required this.hint,
      required this.items,
      required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE9E7E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint,
              style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFFB6B0C3))),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFB6B0C3)),
          style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF06003A)),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(4),
          items: items
              .map((s) => DropdownMenuItem(
                  value: s,
                  child: Text(s,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF06003A)))))
              .toList(),
          onChanged: (v) => onChanged(v ?? ''),
        ),
      ),
    );
  }
}
