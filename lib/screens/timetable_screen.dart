import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'survey_screen.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  bool _isSurveyMode = false;
  int _surveyStep = 1;

  void _startSurvey() {
    setState(() {
      _isSurveyMode = true;
      _surveyStep = 1;
    });
  }

  void _exitSurvey() {
    setState(() {
      _isSurveyMode = false;
      _surveyStep = 1;
    });
  }

  void _goToNextStep() {
    setState(() {
      _surveyStep++;
    });
  }

  void _goToPrevStep() {
    setState(() {
      if (_surveyStep > 1) _surveyStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSurveyMode) {
      if (_surveyStep == 1) {
        return SurveyQuestionScreen(
            onCancel: _exitSurvey, onNext: _goToNextStep);
      } else if (_surveyStep == 2) {
        return SurveyQuestion2Screen(onPrev: _goToPrevStep, onNext: () {});
      }
    }
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
                              onPressed: _startSurvey,
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

// 설문 첫 질문 위젯 (디자인 반영)
class SurveyQuestionScreen extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onNext;
  const SurveyQuestionScreen(
      {Key? key, required this.onCancel, required this.onNext})
      : super(key: key);

  @override
  State<SurveyQuestionScreen> createState() => _SurveyQuestionScreenState();
}

class _SurveyQuestionScreenState extends State<SurveyQuestionScreen> {
  final List<Map<String, String?>> _lectures = [
    {'name': '', 'section': null},
  ];
  final List<String> _sections = ['1분반', '2분반', '3분반', '4분반'];

  void _addLecture() {
    setState(() {
      _lectures.add({'name': '', 'section': null});
    });
  }

  void _updateLectureName(int idx, String value) {
    setState(() {
      _lectures[idx]['name'] = value;
    });
  }

  void _updateLectureSection(int idx, String? value) {
    setState(() {
      _lectures[idx]['section'] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // X 아이콘 (오른쪽 상단)
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.onCancel,
                    child: Image.asset(
                      'assets/cancel.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            // 프로그레스바 + 10% 텍스트 (X 아래)
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 프로그레스바
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0x1A06003A), // rgba(6,0,58,0.1)
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.1, // 10%
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF06003A),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 10% 텍스트
                  const Text(
                    '10%',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0x4D000000), // rgba(0,0,0,0.3)
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                'Q1',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF7B7684),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Text(
                '사전 신청 된 강좌가 있나요?',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
              child: Text(
                '강의명만 입력하거나 강의+분반을 선택해주세요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0x6606003A),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '강의명',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF7B7684),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '분반',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF7B7684),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ..._lectures.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final lecture = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '강의명을 입력하세요',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFFB6B1C2),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (v) => _updateLectureName(idx, v),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: lecture['section'],
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('선택',
                                          style: TextStyle(
                                              color: Color(0xFFB6B1C2))),
                                    ),
                                    ..._sections.map((s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        )),
                                  ],
                                  onChanged: (v) =>
                                      _updateLectureSection(idx, v),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: _addLecture,
                          child: const Row(
                            children: [
                              Icon(Icons.add,
                                  color: Color(0xFF160095), size: 20),
                              SizedBox(width: 4),
                              Text(
                                '강의 추가',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF160095),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06003A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '다음',
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
    );
  }
}

// Q2 전용 시간표 위젯
class SurveyTimetableGrid extends StatefulWidget {
  final List<List<bool>> selected;
  final void Function(int row, int col) onCellTap;
  final void Function(int row, int col) onCellDragStart;
  final void Function(int row, int col) onCellDragUpdate;
  final void Function() onDragEnd;
  const SurveyTimetableGrid({
    super.key,
    required this.selected,
    required this.onCellTap,
    required this.onCellDragStart,
    required this.onCellDragUpdate,
    required this.onDragEnd,
  });

  @override
  State<SurveyTimetableGrid> createState() => _SurveyTimetableGridState();
}

class _SurveyTimetableGridState extends State<SurveyTimetableGrid> {
  static const List<String> days = ['월', '화', '수', '목', '금'];
  static final List<String> hourLabels = List.generate(19, (i) {
    if (i % 2 != 0) return '';
    int hour = 9 + (i ~/ 2);
    if (hour > 12) hour -= 12;
    return hour.toString();
  });
  static const int rowCount = 19;
  static const int colCount = 5;
  static const double cellHeight = 28;
  static const double timeColWidth = 32;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double gridWidth = constraints.maxWidth - timeColWidth;
          final double cellW = gridWidth / colCount;
          return Column(
            children: [
              // 요일 헤더
              Row(
                children: [
                  const SizedBox(width: timeColWidth),
                  ...days.map((d) => SizedBox(
                        width: cellW,
                        child: Center(
                          child: Text(
                            d,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Color(0xFF06003A),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 8),
              // 시간표 셀 (세로 스크롤)
              SizedBox(
                height: 350, // 고정 높이, 필요시 조정
                child: Listener(
                  onPointerUp: (_) => widget.onDragEnd(),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        // 가로 구분선
                        Column(
                          children: List.generate(rowCount + 1, (i) {
                            return Container(
                              height: i == rowCount ? 0 : cellHeight,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xFFE5E5EA),
                                    width: 1,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        // 셀 + 시간 라벨
                        Column(
                          children: List.generate(rowCount, (rowIdx) {
                            return Row(
                              children: [
                                // 시간 라벨
                                SizedBox(
                                  width: timeColWidth,
                                  height: cellHeight,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      hourLabels[rowIdx],
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: rowIdx % 2 == 0
                                            ? const Color(0xFFB6B0C3)
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                ...List.generate(colCount, (colIdx) {
                                  final isSelected =
                                      widget.selected[rowIdx][colIdx];
                                  return GestureDetector(
                                    onTap: () =>
                                        widget.onCellTap(rowIdx, colIdx),
                                    onPanStart: (_) =>
                                        widget.onCellDragStart(rowIdx, colIdx),
                                    onPanUpdate: (_) =>
                                        widget.onCellDragUpdate(rowIdx, colIdx),
                                    child: Container(
                                      width: cellW,
                                      height: cellHeight,
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF6178FA)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 설문 2번: 수강 불가능한 시간 선택
class SurveyQuestion2Screen extends StatefulWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;
  const SurveyQuestion2Screen(
      {Key? key, required this.onPrev, required this.onNext})
      : super(key: key);

  @override
  State<SurveyQuestion2Screen> createState() => _SurveyQuestion2ScreenState();
}

class _SurveyQuestion2ScreenState extends State<SurveyQuestion2Screen> {
  static const int rowCount = 19;
  static const int colCount = 5;
  List<List<bool>> selected =
      List.generate(rowCount, (_) => List.filled(colCount, false));
  bool isDragging = false;
  bool? dragValue;

  void _onCellTap(int row, int col) {
    setState(() {
      selected[row][col] = !selected[row][col];
    });
  }

  void _onCellDragStart(int row, int col) {
    setState(() {
      isDragging = true;
      dragValue = !selected[row][col];
      selected[row][col] = dragValue!;
    });
  }

  void _onCellDragUpdate(int row, int col) {
    if (isDragging && dragValue != null) {
      setState(() {
        selected[row][col] = dragValue!;
      });
    }
  }

  void _onDragEnd() {
    setState(() {
      isDragging = false;
      dragValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 X + 프로그레스바 (20%)
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      'assets/cancel.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0x1A06003A),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.2, // 20%
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF06003A),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '20%',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0x4D000000),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                'Q2',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF7B7684),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Text(
                '수강 불가능한 시간을 선택해주세요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 시간표 그리드 (Q2 전용)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SurveyTimetableGrid(
                  selected: selected,
                  onCellTap: _onCellTap,
                  onCellDragStart: _onCellDragStart,
                  onCellDragUpdate: _onCellDragUpdate,
                  onDragEnd: _onDragEnd,
                ),
              ),
            ),
            // 하단 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: widget.onPrev,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB6B1C2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          '이전',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.loose,
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: widget.onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF06003A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          '다음',
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
    );
  }
}
