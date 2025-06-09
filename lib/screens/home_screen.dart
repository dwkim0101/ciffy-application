import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/home/home_greeting.dart';
import '../widgets/home/home_today_classes.dart';
import '../widgets/home/home_review_section.dart';
import '../widgets/home/timetable_grid.dart';
import '../widgets/home/today_class_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/Logo.svg', width: 70, height: 20),
                const SizedBox(height: 24),
                const HomeGreeting(),
                const SizedBox(height: 20),
                const TodayClassBox(),
                const TimetableGrid(),
                const HomeReviewSection(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
