import 'package:flutter/material.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('시간표짜기', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
