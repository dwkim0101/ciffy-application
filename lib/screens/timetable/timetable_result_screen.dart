import 'package:flutter/material.dart';
import 'package:ciffy_application/widgets/home/timetable_grid.dart';
import 'timetable_detail_screen.dart';
import 'timetable_q2.dart';
import '../../widgets/graduation_analysis/requirement_progress.dart';
import '../../widgets/graduation_analysis/requirement_list.dart';
import 'timetable_intro.dart';
import 'timetable_q1.dart';
import 'timetable_survey_data.dart';
import 'package:provider/provider.dart';
import '../../api/lecture_api.dart';

class _SubjectListView extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;
  const _SubjectListView({required this.subjects});

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) {
      return const Center(child: Text('과목이 없습니다.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...subjects.map((subj) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: ListTile(
                title: Text(subj['course']?['name'] ?? subj['title'] ?? ''),
                subtitle: Text(
                  [
                    subj['professor'] ?? '',
                    (subj['classId'] != null &&
                            (subj['classId'] is String &&
                                (subj['classId'] as String).isNotEmpty))
                        ? '${subj['classId']}분반'
                        : '',
                    subj['time'] ?? ''
                  ]
                      .where((e) => e != null && (e as String).isNotEmpty)
                      .join(' · '),
                ),
              ),
            ))
      ],
    );
  }
}

class TimetableResultScreen extends StatefulWidget {
  final VoidCallback onRestartSurvey;
  const TimetableResultScreen({Key? key, required this.onRestartSurvey})
      : super(key: key);

  @override
  State<TimetableResultScreen> createState() => _TimetableResultScreenState();
}

class _TimetableResultScreenState extends State<TimetableResultScreen> {
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

  void _openDetail(Map<String, dynamic> timetable) {
    final majors = timetable['majors'] as List? ?? [];
    final liberals = timetable['liberals'] as List? ?? [];
    final List<Map<String, String>> subjects = [];
    for (final item in [...majors, ...liberals]) {
      final course = item['course'] as Map?;
      if (course == null) continue;
      final title = course['name']?.toString() ?? '';
      final professor = item['professor']?.toString() ?? '';
      final time = item['time']?.toString() ?? '';
      subjects.add({
        'title': title,
        'professor': professor,
        'time': time,
      });
    }
    setState(() {
      _showDetail = true;
      _detailLectures = subjects;
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
    final timetableProvider = Provider.of<TimetableResultProvider>(context);
    final timetables = timetableProvider.timetables;
    final loading = timetableProvider.loading;
    final error = timetableProvider.error;

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (error != null) {
      return Scaffold(
        body: Center(
            child:
                Text('에러: $error', style: const TextStyle(color: Colors.red))),
      );
    }
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
                    // 과목 리스트만 시각화
                    _SubjectListView(subjects: _detailLectures),
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
    // 결과 화면
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
                child: timetables.isEmpty
                    ? const Center(child: Text('생성된 시간표가 없습니다.'))
                    : PageView.builder(
                        itemCount: timetables.length,
                        controller: PageController(viewportFraction: 0.85),
                        onPageChanged: (idx) => setState(() {
                          _currentPage = idx;
                          _selectedIndex = null;
                        }),
                        itemBuilder: (context, idx) {
                          final timetable = timetables[idx];
                          final map = timetable;
                          final majors = map['majors'] as List? ?? [];
                          final liberals = map['liberals'] as List? ?? [];
                          print('majors: $majors');
                          print('liberals: $liberals');
                          final List<Map<String, String>> subjects = [];
                          for (final item in [...majors, ...liberals]) {
                            final course = item['course'] as Map?;
                            if (course == null) continue;
                            final title = course['name']?.toString() ?? '';
                            final professor =
                                item['professor']?.toString() ?? '';
                            final time = item['time']?.toString() ?? '';
                            print(
                                'title: $title, professor: $professor, time: $time');
                            subjects.add({
                              'title': title,
                              'professor': professor,
                              'time': time,
                            });
                          }
                          print('subjects: $subjects');
                          if (subjects.isEmpty) {
                            return const Center(child: Text('과목 없음'));
                          }
                          // 시간표 그리드에 맞게 변환 + 온라인 강의 분리
                          List<Map<String, dynamic>> onlineLectures = [];
                          List<Map<String, dynamic>> convertSubjectsForGrid(
                              List<Map<String, String>> subjects) {
                            const days = ['월', '화', '수', '목', '금'];
                            List<Map<String, dynamic>> result = [];
                            onlineLectures.clear();
                            for (final subj in subjects) {
                              final time = subj['time'] ?? '';
                              if (time.trim().isEmpty) {
                                onlineLectures.add({
                                  'title': subj['title'],
                                  'professor': subj['professor'],
                                });
                                continue;
                              }
                              final matches = RegExp(
                                      r'([월화수목금])(?:\s)?(\d{2}:\d{2})~(\d{2}:\d{2})')
                                  .allMatches(time);
                              for (final m in matches) {
                                final dayIdx = days.indexOf(m.group(1)!);
                                if (dayIdx == -1) continue;
                                final start = m.group(2)!;
                                final end = m.group(3)!;
                                int timeToIndex(String t) {
                                  final parts = t.split(':');
                                  final hour = int.parse(parts[0]);
                                  final min = int.parse(parts[1]);
                                  return (hour - 9) * 2 + (min >= 30 ? 1 : 0);
                                }

                                final startIdx = timeToIndex(start);
                                final endIdx = timeToIndex(end);
                                if (startIdx < 0 ||
                                    startIdx > 18 ||
                                    endIdx < 1 ||
                                    endIdx > 19) continue;
                                result.add({
                                  'title': subj['title'],
                                  'professor': subj['professor'],
                                  'day': dayIdx,
                                  'start': start,
                                  'end': end,
                                });
                              }
                            }
                            return result;
                          }

                          final gridLectures = convertSubjectsForGrid(subjects);
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 12, bottom: 60, right: 12, left: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 420, // 고정 높이로 overflow 방지
                                  child: TimetableGrid(
                                    lectures: gridLectures,
                                    padding: const EdgeInsets.all(
                                        20), // 내부 그리드 padding 원래대로
                                  ),
                                ),
                                if (onlineLectures.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 4,
                                        right: 4,
                                        bottom: 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('온라인 강의',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF160095))),
                                        const SizedBox(height: 4),
                                        ...onlineLectures.map((lec) => Text(
                                              '${lec['title']} ${lec['professor'] != null && lec['professor']!.isNotEmpty ? '· ${lec['professor']}' : ''}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF160095)),
                                            )),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          if (timetables.isNotEmpty)
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
                            _openDetail(timetables[_selectedIndex ?? 0]);
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

  // TimetableGrid의 timeToIndex와 동일하게, 9:00~18:30만 허용
  int? _safeTimeToIndex(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final min = int.tryParse(parts[1]);
    if (hour == null || min == null) return null;
    final idx = (hour - 9) * 2 + (min >= 30 ? 1 : 0);
    if (idx < 0 || idx > 18) return null;
    return idx;
  }
}
