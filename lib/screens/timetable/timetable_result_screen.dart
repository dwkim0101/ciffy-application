import 'package:flutter/material.dart';
import 'package:ciffy_application/widgets/home/timetable_grid.dart';
import 'timetable_detail_screen.dart';
import 'timetable_q2.dart';
import '../../widgets/graduation_analysis/requirement_progress.dart';
import '../../widgets/graduation_analysis/requirement_list.dart';
import 'timetable_intro.dart';
import 'timetable_q1.dart';
import 'timetable_survey_data.dart';

class TimetableResultScreen extends StatefulWidget {
  final VoidCallback onRestartSurvey;
  const TimetableResultScreen({Key? key, required this.onRestartSurvey})
      : super(key: key);

  @override
  State<TimetableResultScreen> createState() => _TimetableResultScreenState();
}

class _TimetableResultScreenState extends State<TimetableResultScreen> {
  // mockTimetables: 각 시간표별 강의 리스트
  final List<List<Map<String, dynamic>>> mockTimetables = [
    [
      {
        'title': '인도의정치경제와사회',
        'room': '집401',
        'professor': '이지은',
        'day': 0,
        'start': '09:00',
        'end': '10:30',
      },
      {
        'title': '강의명',
        'room': '강의실',
        'professor': '교수님',
        'day': 1,
        'start': '12:00',
        'end': '13:30',
      },
      {
        'title': '강의명',
        'room': '강의실',
        'professor': '교수님',
        'day': 2,
        'start': '12:00',
        'end': '13:30',
      },
      {
        'title': '강의명',
        'room': '강의실',
        'professor': '교수님',
        'day': 3,
        'start': '12:00',
        'end': '13:30',
      },
      {
        'title': '강의명',
        'room': '강의실',
        'professor': '교수님',
        'day': 4,
        'start': '12:00',
        'end': '13:30',
      },
    ],
    [
      {
        'title': '인도의정치경제와사회',
        'room': '집401',
        'professor': '이지은',
        'day': 0,
        'start': '09:00',
        'end': '10:30',
      },
      {
        'title': '강의명',
        'room': '강의실',
        'professor': '교수님',
        'day': 1,
        'start': '13:00',
        'end': '14:30',
      },
      {
        'title': '강의명',
        'room': '강의실',
        'professor': '교수님',
        'day': 2,
        'start': '13:00',
        'end': '14:30',
      },
    ],
  ];
  int _currentPage = 0;
  int? _selectedIndex;
  bool _showDetail = false;
  List<Map<String, dynamic>> _detailLectures = const [];

  // 임시 데이터
  final List<Map<String, String>> _mockReviews = [
    {
      'title': '인도의정치경제와사회',
      'professor': '이지은 교수님',
      'content': '교수님이 친절하고 과제가 적어요.'
    },
    {'title': '강의명', 'professor': '정땡땡 교수님', 'content': '시험이 쉬워요.'},
  ];
  final Map<String, double> _mockGradProgress = {
    '전공필수': 23 / 33,
    '전공선택': 23 / 33,
  };
  final Map<String, List<String>> _mockGradDetail = {
    '전공필수': ['A과목', 'B과목'],
    '전공선택': ['C과목', 'D과목'],
  };

  void _openDetail(List<Map<String, dynamic>> lectures) {
    setState(() {
      _showDetail = true;
      _detailLectures = lectures;
    });
  }

  void _closeDetail() {
    setState(() {
      _showDetail = false;
      _detailLectures = const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showDetail) {
      // 자세히 보기 화면
      return Scaffold(
        backgroundColor: const Color(0xFFF8F6F3),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF06003A)),
            onPressed: _closeDetail,
          ),
          title: const Text(
            '시간표 자세히보기',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFF06003A),
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 분석 배너
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF160095),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '시피가 시간표를 분석해봤어요!',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '팀플과 과제가 적고, 전공 필수 과목이 많은 시간표예요.',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Placeholder(), // TODO: 캐릭터 이미지로 교체
                          ),
                        ],
                      ),
                    ),
                    // 시간표 그리드(홈 컴포넌트 재사용)
                    TimetableGrid(lectures: _detailLectures),
                    const SizedBox(height: 32),
                    // 강의후기(후기 컴포넌트 재사용)
                    const Text(
                      '강의후기 모아보기',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF06003A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._mockReviews.map((r) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['title'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color(0xFF06003A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                r['professor'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xFF8886A3),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                r['content'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF06003A),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 32),
                    // 졸업요건(졸업분석 컴포넌트 재사용)
                    const Text(
                      '학기 종료 후 예상 졸업요건',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF06003A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const RequirementProgress(), // TODO: 데이터 연결
                    const SizedBox(height: 24),
                    const RequirementList(), // TODO: 데이터 연결
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TimetableQ2ButtonBar(
                onPrev: _closeDetail,
                onNext: widget.onRestartSurvey,
                nextLabel: '선택하기',
              ),
            ),
          ],
        ),
      );
    }
    // 결과 화면(기존)
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '시간표가 완성되었어요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    height: 1.0,
                    color: Color(0xFF160095),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '마음에 드는 시간표를 눌러 자세히 볼 수 있어요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.4,
                    color: Color.fromRGBO(6, 0, 58, 0.4),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: mockTimetables.length,
                  controller: PageController(viewportFraction: 0.85),
                  onPageChanged: (idx) => setState(() {
                    _currentPage = idx;
                    _selectedIndex = null;
                  }),
                  itemBuilder: (context, idx) {
                    return GestureDetector(
                      onTap: () => setState(() => _selectedIndex = idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.symmetric(
                          vertical: _selectedIndex == idx ? 8 : 24,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: _selectedIndex == idx
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: TimetableGrid(lectures: mockTimetables[idx]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (_selectedIndex != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedIndex == null) return;
                            _openDetail(mockTimetables[_selectedIndex!]);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE6E3ED),
                            foregroundColor: const Color(0xFF160095),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '자세히 보기',
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
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: widget.onRestartSurvey,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF160095),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '선택하기',
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
            ),
        ],
      ),
    );
  }
}
