import 'package:flutter/material.dart';
import '../widgets/graduation_analysis/summary_card.dart';
import '../widgets/graduation_analysis/requirement_progress.dart';
import '../widgets/graduation_analysis/requirement_list.dart';

class GraduationAnalysisScreen extends StatelessWidget {
  const GraduationAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF06003A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '졸업요건 분석',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF06003A),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SummaryCard(),
              SizedBox(height: 24),
              RequirementProgress(),
              SizedBox(height: 24),
              RequirementList(),
            ],
          ),
        ),
      ),
    );
  }
}
