import 'package:flutter/material.dart';
import '../../widgets/home/timetable_grid.dart';
import '../../widgets/review/review_detail_header.dart';
import '../../widgets/graduation_analysis/requirement_progress.dart';
import '../../widgets/graduation_analysis/requirement_list.dart';

class TimetableDetailScreen extends StatelessWidget {
  final List<Map<String, dynamic>> lectures;
  final List<Map<String, String>> reviews;
  final Map<String, double> gradProgress;
  final Map<String, List<String>> gradDetail;

  const TimetableDetailScreen({
    super.key,
    required this.lectures,
    required this.reviews,
    required this.gradProgress,
    required this.gradDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        iconTheme: const IconThemeData(color: Color(0xFF06003A)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  // 캐릭터/일러스트 자리(옵션)
                  SizedBox(width: 12),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Placeholder(), // TODO: 캐릭터 이미지로 교체
                  ),
                ],
              ),
            ),
            // 시간표 그리드
            TimetableGrid(lectures: lectures),
            const SizedBox(height: 32),
            // 강의후기 섹션
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
            ...reviews.map((r) => Container(
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
            // 졸업요건 진행률
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
            const RequirementProgress(), // TODO: gradProgress 데이터 연결
            const SizedBox(height: 24),
            const RequirementList(), // TODO: gradDetail 데이터 연결
          ],
        ),
      ),
    );
  }
}
