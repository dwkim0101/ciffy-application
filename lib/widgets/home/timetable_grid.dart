import 'package:flutter/material.dart';

class TimetableGrid extends StatelessWidget {
  final List<Map<String, dynamic>> lectures;
  final EdgeInsets? padding;
  const TimetableGrid(
      {super.key,
      this.lectures = const [
        {
          'title': '인도의정치경제와사회',
          'room': '집401',
          'professor': '이지은',
          'day': 0, // 월
          'start': '09:00',
          'end': '10:30',
        },
        {
          'title': '그래픽디자인1',
          'room': '302',
          'professor': '김철수',
          'day': 1, // 화
          'start': '10:00',
          'end': '11:30',
        },
        {
          'title': '스마트UX&UI디자인1',
          'room': '302',
          'professor': '박영희',
          'day': 0, // 월
          'start': '13:00',
          'end': '14:30',
        },
      ],
      this.padding});

  // 30분 단위 타임슬롯 생성 (9:00~18:00, 18:00 포함)
  static final List<String> timeSlots = List.generate(19, (i) {
    final hour = 9 + (i ~/ 2);
    final min = (i % 2) * 30;
    return '${hour.toString().padLeft(2, '0')}:${min == 0 ? '00' : '30'}';
  });

  // 시간 라벨(1시간 단위만 12시간제, 30분 단위는 빈칸)
  static final List<String> hourLabels = List.generate(19, (i) {
    if (i % 2 != 0) return '';
    int hour = 9 + (i ~/ 2);
    if (hour > 12) hour -= 12;
    return hour.toString();
  });

  // 요일
  static const List<String> days = ['월', '화', '수', '목', '금'];

  // 시간 문자열을 인덱스로 변환
  int timeToIndex(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final min = int.parse(parts[1]);
    return (hour - 9) * 2 + (min >= 30 ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    // [row][col] 구조의 timetable 생성 (row: timeSlot, col: day)
    List<List<Map<String, dynamic>?>> grid = List.generate(
      timeSlots.length,
      (_) => List.filled(days.length, null),
    );
    for (final lec in lectures) {
      final col = lec['day'] as int;
      final startIdx = timeToIndex(lec['start'] as String);
      final endIdx = timeToIndex(lec['end'] as String);
      final duration = endIdx - startIdx;
      grid[startIdx][col] = {
        'title': lec['title'],
        'professor': lec['professor'],
        'room': lec['room'],
        'duration': duration,
      };
      for (int i = 1; i < duration; i++) {
        grid[startIdx + i][col] = null;
      }
    }

    // 레이아웃 상수
    const double cellHeight = 18; // 카드 간격 넓힘
    const double timeColWidth = 32;
    const double gridTopPadding = 12;
    final int rowCount = timeSlots.length;
    final int colCount = days.length;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      padding: padding ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double gridWidth = constraints.maxWidth;
          final double cellW = gridWidth / colCount / 1.2;

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
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Color(0xFF06003A),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: gridTopPadding),
              // Stack 구조: 배경 그리드(선) + 강의 블록
              SizedBox(
                height: cellHeight * rowCount, // 9:00~18:00(19칸) 항상 보이도록
                child: Stack(
                  children: [
                    // 1. 배경 그리드 (선만)
                    CustomPaint(
                      size:
                          Size(gridWidth + timeColWidth, cellHeight * rowCount),
                      painter: _GridLinePainter(
                        rowCount: rowCount,
                        colCount: colCount,
                        cellHeight: cellHeight,
                        cellWidth: cellW,
                        timeColWidth: timeColWidth,
                        lineColor: const Color(0xFFF0F0F5),
                      ),
                    ),
                    // 2. 시간 라벨
                    Column(
                      children: List.generate(rowCount, (rowIdx) {
                        return SizedBox(
                          height: cellHeight,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                hourLabels[rowIdx],
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: rowIdx % 2 == 0
                                      ? const Color(0xFFB6B0C3)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    // 3. 강의 블록 (포지션 계산)
                    ...lectures.map((lec) {
                      final int col = lec['day'] as int;
                      final int startIdx = timeToIndex(lec['start'] as String);
                      final int endIdx = timeToIndex(lec['end'] as String);
                      final int duration = endIdx - startIdx;
                      return Positioned(
                        left: timeColWidth + col * cellW,
                        top: startIdx * cellHeight,
                        width: cellW,
                        height: cellHeight * duration,
                        child: Container(
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6178FA),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                lec['title'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              if ((lec['professor'] ?? '').isNotEmpty)
                                Text(
                                  lec['professor'],
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 그리드 선만 그리는 CustomPainter
class _GridLinePainter extends CustomPainter {
  final int rowCount;
  final int colCount;
  final double cellHeight;
  final double cellWidth;
  final double timeColWidth;
  final Color lineColor;

  _GridLinePainter({
    required this.rowCount,
    required this.colCount,
    required this.cellHeight,
    required this.cellWidth,
    required this.timeColWidth,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    // 가로선만 그림
    for (int i = 0; i <= rowCount; i++) {
      final y = i * cellHeight;
      canvas.drawLine(
        Offset(timeColWidth, y),
        Offset(timeColWidth + colCount * cellWidth, y),
        paint,
      );
    }
    // 세로선은 그리지 않음
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
