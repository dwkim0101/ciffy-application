import 'package:flutter/material.dart';
import '../timetable/timetable_survey_data.dart';
import 'timetable_q2.dart';

class TimetableQ4 extends StatefulWidget {
  final TimeTableSurveyData data;
  final VoidCallback onCancel;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final void Function(TimeTableSurveyData) onChanged;
  const TimetableQ4({
    Key? key,
    required this.data,
    required this.onCancel,
    required this.onPrev,
    required this.onNext,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimetableQ4> createState() => _TimetableQ4State();
}

class _TimetableQ4State extends State<TimetableQ4> {
  int selectedCount = 0;

  @override
  void initState() {
    super.initState();
    selectedCount = widget.data.majorRequiredCount ?? 0;
  }

  void _onSliderChanged(double value) {
    setState(() {
      selectedCount = value.round();
      widget.onChanged(widget.data..majorRequiredCount = selectedCount);
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
            // 상단 X + 프로그레스바 (40%)
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.onCancel,
                    child: const Icon(Icons.close,
                        size: 28, color: Color(0xFF160095)),
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
                        color: const Color(0xFFD9D7E0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.4, // 40%
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF160095),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '40%',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0x994D4D4D),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                'Q4',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF9B98AC),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Text(
                '전공 필수 과목은 몇 개를 수강하고 싶으신가요?',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF16003A),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 48),
            Center(
              child: SizedBox(
                width: 320,
                child: _MajorRequiredSlider(
                  value: selectedCount,
                  onChanged: _onSliderChanged,
                ),
              ),
            ),
            const Spacer(),
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

class _MajorRequiredSlider extends StatelessWidget {
  final int value;
  final ValueChanged<double> onChanged;
  const _MajorRequiredSlider({required this.value, required this.onChanged});

  static const Color activeColor = Color(0xFF6178FA); // 피그마 파랑
  static const Color inactiveColor = Color(0xFFE6E6F0); // 피그마 연보라
  static const Color thumbBorder = Color(0xFF6178FA);
  static const Color tickActive = Color(0xFF6178FA);
  static const Color tickInactive = Colors.white;
  static const Color tickBorder = Color(0xFF6178FA);
  static const double trackHeight = 8;
  static const double tickSize = 12;
  static const double thumbSize = 28;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 트랙(연보라)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: trackHeight,
                    decoration: BoxDecoration(
                      color: inactiveColor,
                      borderRadius: BorderRadius.circular(trackHeight / 2),
                    ),
                  ),
                ),
              ),
              // active 트랙(파랑)
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double percent = value / 5;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: percent == 0 ? 0.01 : percent, // 최소 1% 보정
                        child: Container(
                          height: trackHeight,
                          decoration: BoxDecoration(
                            color: activeColor,
                            borderRadius:
                                BorderRadius.circular(trackHeight / 2),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // 틱(점)
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        6,
                        (i) => Container(
                              width: tickSize,
                              height: tickSize,
                              decoration: BoxDecoration(
                                color: i <= value ? tickActive : tickInactive,
                                border: Border.all(color: tickBorder, width: 2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  if (i == value)
                                    const BoxShadow(
                                      color: Color(0x1A6178FA),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset: Offset(0, 2),
                                    ),
                                ],
                              ),
                            )),
                  ),
                ),
              ),
              // 슬라이더(투명, 값만 전달)
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0, // 트랙 숨김
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  thumbColor: Colors.white,
                  overlayColor: Colors.transparent,
                  thumbShape: const _CustomThumbShape(),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                ),
                child: Slider(
                  min: 0,
                  max: 5,
                  divisions: 5,
                  value: value.toDouble(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (i) => Text(
              '$i',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0x6606003A), // rgba(6,0,58,0.4)
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  const _CustomThumbShape();
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(28, 28);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Paint borderPaint = Paint()
      ..color = _MajorRequiredSlider.thumbBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, 14, borderPaint);
    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 13, fillPaint);
  }
}
