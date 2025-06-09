import 'package:flutter/material.dart';
import '../widgets/graduation_analysis/summary_card.dart';
import '../widgets/graduation_analysis/area_card.dart';
import '../widgets/graduation_analysis/area_item_bar.dart';
import '../widgets/graduation_analysis/grad_cert_card.dart';
import '../widgets/graduation_analysis/grad_colors.dart';

class GraduationAnalysisScreen extends StatelessWidget {
  const GraduationAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final majorItems = [
      const AreaItemBar(
        label: '전공필수',
        current: 23,
        total: 33,
        color: 23 == 33 ? GradColors.progressMain : GradColors.progressSub,
      ),
      const AreaItemBar(
        label: '전공선택',
        current: 23,
        total: 33,
        color: 23 == 33 ? GradColors.progressMain : GradColors.progressSub,
      ),
    ];
    final liberalItems = [
      const AreaItemBar(
        label: '공통교양필수',
        current: 23,
        total: 33,
        color: 23 == 33 ? GradColors.progressMain : GradColors.progressSub,
      ),
      const AreaItemBar(
        label: '학문기초교양필수',
        current: 23,
        total: 33,
        color: 23 == 33 ? GradColors.progressMain : GradColors.progressSub,
      ),
      const AreaItemBar(
        label: '교양선택',
        current: 23,
        total: 33,
        color: 23 == 33 ? GradColors.progressMain : GradColors.progressSub,
      ),
    ];
    final certItems = [
      GradCertItem(name: '영어졸업인증', passed: true, percent: 1.0),
      GradCertItem(name: '고전독서인증', passed: false, percent: 0.5),
      GradCertItem(name: '소프트웨어코딩\n졸업인증', passed: false, percent: 0.5),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 텍스트 (AppBar 대신)
              const SizedBox(height: 8),
              const Text(
                '졸업요건분석',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF06003A),
                ),
              ),
              const SizedBox(height: 24),
              const SummaryCard(),
              const SizedBox(height: 24),
              AreaCard(title: '전공', onDetail: () {}, children: majorItems),
              AreaCard(title: '교양', onDetail: () {}, children: liberalItems),
              GradCertCard(
                passed: 1,
                total: 2,
                certs: certItems,
                guideText: '3개 중 2개 이상 통과해야함',
                onDetail: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
