import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';

class TimetableQ2 extends StatefulWidget {
  final TimeTableSurveyData data;
  final VoidCallback onCancel;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final void Function(TimeTableSurveyData) onChanged;
  const TimetableQ2(
      {Key? key,
      required this.data,
      required this.onCancel,
      required this.onPrev,
      required this.onNext,
      required this.onChanged})
      : super(key: key);

  @override
  State<TimetableQ2> createState() => _TimetableQ2State();
}

class _TimetableQ2State extends State<TimetableQ2> {
  static const List<String> days = ['월', '화', '수', '목', '금'];
  static const List<String> hourLabels = [
    '9',
    '',
    '10',
    '',
    '11',
    '',
    '12',
    '',
    '1',
    '',
    '2',
    '',
    '3',
    '',
    '4',
    '',
    '5',
    '',
    '6',
    '',
    '7',
    '',
  ];
  static const int rowCount = 22;
  static const int colCount = 5;

  late List<List<bool>> selected;
  bool isDragging = false;
  bool? dragValue;

  @override
  void initState() {
    super.initState();
    selected = List<List<bool>>.generate(
        rowCount,
        (i) => List<bool>.from(widget.data.unavailableTimes.length > i
            ? widget.data.unavailableTimes[i]
            : List.filled(colCount, false)));
  }

  void _onCellTap(int row, int col) {
    setState(() {
      selected[row][col] = !selected[row][col];
      _notifyChange();
    });
  }

  void _onCellDragStart(int row, int col) {
    setState(() {
      isDragging = true;
      dragValue = !selected[row][col];
      selected[row][col] = dragValue!;
      _notifyChange();
    });
  }

  void _onCellDragUpdate(int row, int col) {
    if (isDragging && dragValue != null) {
      setState(() {
        selected[row][col] = dragValue!;
        _notifyChange();
      });
    }
  }

  void _onDragEnd() {
    setState(() {
      isDragging = false;
      dragValue = null;
    });
  }

  void _notifyChange() {
    widget.onChanged(
        widget.data..unavailableTimes = List<List<bool>>.from(selected));
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
            // 시간표 그리드 (디자인 맞춤)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TimetableQ2Grid(
                  selected: selected,
                  onCellTap: _onCellTap,
                  onCellDragStart: _onCellDragStart,
                  onCellDragUpdate: _onCellDragUpdate,
                  onDragEnd: _onDragEnd,
                ),
              ),
            ),
            // 하단 버튼 (디자인 맞춤)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TimetableQ2ButtonBar(
                onPrev: widget.onPrev,
                onNext: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimetableQ2Grid extends StatelessWidget {
  final List<List<bool>> selected;
  final void Function(int row, int col) onCellTap;
  final void Function(int row, int col) onCellDragStart;
  final void Function(int row, int col) onCellDragUpdate;
  final void Function() onDragEnd;
  const TimetableQ2Grid(
      {super.key,
      required this.selected,
      required this.onCellTap,
      required this.onCellDragStart,
      required this.onCellDragUpdate,
      required this.onDragEnd});

  static const List<String> days = ['월', '화', '수', '목', '금'];
  static const List<String> hourLabels = [
    '9',
    '',
    '10',
    '',
    '11',
    '',
    '12',
    '',
    '1',
    '',
    '2',
    '',
    '3',
    '',
    '4',
    '',
    '5',
    '',
    '6',
    '',
    '7',
    '',
  ];
  static const int rowCount = 24;
  static const int colCount = 5;
  static const double timeColWidth = 28;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 5 / 7, // col:row 비율에 맞게
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 카드 내부 가용 크기
            final double cardWidth = constraints.maxWidth.clamp(220, 340);
            final double cardHeight = constraints.maxHeight.clamp(320, 520);
            const double timeColWidth = 28;
            const double cellMargin = 2;
            const double cardPadding = 12;
            const double headerHeight = 36;
            const int rowCount = 22;
            const int colCount = 5;
            final double availableHeight =
                cardHeight - headerHeight - cardPadding * 2;
            final double availableWidth =
                cardWidth - timeColWidth - cardPadding * 2;
            final double cellHeight =
                (availableHeight - (cellMargin * 2 * rowCount)) / rowCount;
            final double cellWidth =
                (availableWidth - (cellMargin * 2 * colCount)) / colCount;
            return Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 요일 헤더
                  SizedBox(
                    height: headerHeight,
                    child: Row(
                      children: [
                        const SizedBox(width: timeColWidth),
                        ...List.generate(
                            colCount,
                            (colIdx) => Container(
                                  width: cellWidth,
                                  margin: const EdgeInsets.all(cellMargin),
                                  alignment: Alignment.center,
                                  child: Text(
                                    days[colIdx],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF06003A),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                  // 시간표 그리드
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 시간 라벨 (2칸 합치기, Expanded로 비율 맞춤)
                        Column(
                          children: List.generate(rowCount, (rowIdx) {
                            if (rowIdx % 2 == 0) {
                              // 정시: 2칸 높이(Expanded flex:2)
                              return Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    hourLabels[rowIdx],
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xFFB6B0C3),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // 30분: 1칸 높이(Expanded flex:1)
                              return const Expanded(
                                  flex: 1, child: SizedBox.shrink());
                            }
                          }),
                        ),
                        // 셀 그리드
                        Expanded(
                          child: Column(
                            children: List.generate(rowCount, (rowIdx) {
                              return Expanded(
                                flex: 1,
                                child: Row(
                                  children: List.generate(colCount, (colIdx) {
                                    final isSelected = selected[rowIdx][colIdx];
                                    return Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () => onCellTap(rowIdx, colIdx),
                                        onPanStart: (_) =>
                                            onCellDragStart(rowIdx, colIdx),
                                        onPanUpdate: (_) =>
                                            onCellDragUpdate(rowIdx, colIdx),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.all(cellMargin),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(0xFF6178FA)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TimetableQ2ButtonBar extends StatelessWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;
  const TimetableQ2ButtonBar(
      {super.key, required this.onPrev, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: onPrev,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8C6D1), // 연보라
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06003A), // 남색
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
    );
  }
}
