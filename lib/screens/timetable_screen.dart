import 'package:flutter/material.dart';
import 'timetable/timetable_intro.dart';
import 'timetable/timetable_q1.dart';
import 'timetable/timetable_q2.dart';
import 'timetable/timetable_survey_data.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  int _surveyStep = 0; // 0: 인트로, 1: Q1, 2: Q2, ...
  final TimeTableSurveyData _surveyData = TimeTableSurveyData();

  void _goToIntro() {
    setState(() {
      _surveyStep = 0;
    });
  }

  void _goToQ1() {
    setState(() {
      _surveyStep = 1;
    });
  }

  void _goToQ2() {
    setState(() {
      _surveyStep = 2;
    });
  }

  void _onSurveyDataChanged(TimeTableSurveyData data) {
    // 필요시 setState로 갱신
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    switch (_surveyStep) {
      case 0:
        return TimetableIntro(onStartSurvey: _goToQ1);
      case 1:
        return TimetableQ1(
          data: _surveyData,
          onCancel: _goToIntro,
          onNext: _goToQ2,
          onChanged: _onSurveyDataChanged,
        );
      case 2:
        return TimetableQ2(
          data: _surveyData,
          onCancel: _goToIntro,
          onPrev: _goToQ1,
          onNext: () {}, // TODO: Q3로 이동
          onChanged: _onSurveyDataChanged,
        );
      default:
        return TimetableIntro(onStartSurvey: _goToQ1);
    }
  }
}
