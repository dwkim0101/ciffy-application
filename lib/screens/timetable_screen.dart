import 'package:flutter/material.dart';
import 'timetable/timetable_intro.dart';
import 'timetable/timetable_q1.dart';
import 'timetable/timetable_q2.dart';
import 'timetable/timetable_q3.dart';
import 'timetable/timetable_q4.dart';
import 'timetable/timetable_q5.dart';
import 'timetable/timetable_survey_data.dart';
import 'timetable/timetable_q6to9.dart';
import 'timetable/timetable_q10.dart';
import 'timetable/timetable_test_complete.dart';
import 'timetable/timetable_result_screen.dart';

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

  void _goToQ3() {
    setState(() {
      _surveyStep = 3;
    });
  }

  void _goToQ4() {
    setState(() {
      _surveyStep = 4;
    });
  }

  void _goToQ5() {
    setState(() {
      _surveyStep = 5;
    });
  }

  void _goToQ6() {
    setState(() {
      _surveyStep = 6;
    });
  }

  void _goToQ7() {
    setState(() {
      _surveyStep = 7;
    });
  }

  void _goToQ8() {
    setState(() {
      _surveyStep = 8;
    });
  }

  void _goToQ9() {
    setState(() {
      _surveyStep = 9;
    });
  }

  void _goToQ10() {
    setState(() {
      _surveyStep = 10;
    });
  }

  void _goToTestComplete() {
    setState(() {
      _surveyStep = 11;
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
          onNext: _goToQ3,
          onChanged: _onSurveyDataChanged,
        );
      case 3:
        return TimetableQ3(
          data: _surveyData,
          onCancel: _goToIntro,
          onPrev: _goToQ2,
          onNext: _goToQ4,
          onChanged: _onSurveyDataChanged,
        );
      case 4:
        return TimetableQ4(
          data: _surveyData,
          onCancel: _goToIntro,
          onPrev: _goToQ3,
          onNext: _goToQ5,
          onChanged: _onSurveyDataChanged,
        );
      case 5:
        return TimetableQ5(
          data: _surveyData,
          onCancel: _goToIntro,
          onPrev: _goToQ4,
          onNext: _goToQ6,
          onChanged: _onSurveyDataChanged,
        );
      case 6:
        return TimetableQ6to9(
          question: '과제 분량은 어느 정도를 선호하시나요?',
          options: const ['적을수록 좋다', '적당한 것이 좋다', '많을수록 좋다'],
          progress: 0.6,
          value: _surveyData.q6Answer,
          onChanged: (v) => setState(() => _surveyData.q6Answer = v),
          onPrev: _goToQ5,
          onNext: _goToQ7,
          onCancel: _goToIntro,
        );
      case 7:
        return TimetableQ6to9(
          question: '출석 확인 방식은 어느 것을 선호하시나요?',
          options: const ['전자출결', '직접 호명', '상관 없다'],
          progress: 0.7,
          value: _surveyData.q7Answer,
          onChanged: (v) => setState(() => _surveyData.q7Answer = v),
          onPrev: _goToQ6,
          onNext: _goToQ8,
          onCancel: _goToIntro,
        );
      case 8:
        return TimetableQ6to9(
          question: '선호하는 시험 개수의 정도를 알려주세요',
          options: const ['최대한 적은 것이 좋다', '보통', '많을수록 좋다'],
          progress: 0.8,
          value: _surveyData.q8Answer,
          onChanged: (v) => setState(() => _surveyData.q8Answer = v),
          onPrev: _goToQ7,
          onNext: _goToQ9,
          onCancel: _goToIntro,
        );
      case 9:
        return TimetableQ6to9(
          question: '팀플은 얼마나 선호하시나요?',
          options: const ['선호하지 않는다', '보통', '매우 선호한다'],
          progress: 0.9,
          value: _surveyData.q9Answer,
          onChanged: (v) => setState(() => _surveyData.q9Answer = v),
          onPrev: _goToQ8,
          onNext: _goToQ10,
          onCancel: _goToIntro,
        );
      case 10:
        return TimetableQ10(
          data: _surveyData,
          onCancel: _goToIntro,
          onPrev: _goToQ9,
          onFinish: _goToTestComplete,
          onChanged: _onSurveyDataChanged,
        );
      case 11:
        return TimetableTestComplete(
            onComplete: () => setState(() => _surveyStep = 12));
      case 12:
        return const TimetableResultScreen();
      default:
        return TimetableIntro(onStartSurvey: _goToQ1);
    }
  }
}
