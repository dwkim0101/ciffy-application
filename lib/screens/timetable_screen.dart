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
import 'package:provider/provider.dart';
import '../api/lecture_api.dart';
import '../api/api_client.dart';
import 'login_screen.dart';

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

  Future<void> _onTestComplete(BuildContext context) async {
    // Provider 불러오기
    final timetableProvider =
        Provider.of<TimetableResultProvider>(context, listen: false);
    timetableProvider.setLoading(true);
    timetableProvider.setError(null);
    try {
      // 설문 데이터를 API 요청 포맷으로 변환
      final user = UserStore.user;
      final body = {
        "preRegistered": [],
        "unavailableTimes":
            _convertUnavailableTimes(_surveyData.unavailableTimes),
        "wishLectures": _surveyData.majorWishLectures
            .map((e) =>
                "${e['name'] ?? ''}${e['professor'] != null ? '-${e['professor']}' : ''}")
            .where((s) => s.trim().isNotEmpty)
            .toList(),
        "majorCount": _surveyData.majorRequiredCount,
        "major": user?.major ?? '',
        "currentSemester": user?.grade ?? 1,
        "maxCredits": 21,
        "maxTimetables": 5,
      };
      final dio = ApiClient.dio;
      print('시간표 생성 요청 body:');
      print(body);
      final response = await dio.post(
        'http://3.105.9.139:3000/api/timetable/create',
        data: body,
      );
      print('statusCode: \\${response.statusCode}');
      print('response.data:');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // 결과 파싱 및 Provider 저장
        final data = response.data;
        // created.json 구조에 맞게 파싱 필요
        final timetables = _parseTimetableResult(data);
        print('파싱된 timetables: $timetables');
        timetableProvider.setTimetables(timetables);
        print('setTimetables: $timetables');
        timetableProvider.setLoading(false);
        setState(() => _surveyStep = 12);
      } else {
        timetableProvider.setError('서버 오류');
        timetableProvider.setLoading(false);
      }
    } catch (e, stack) {
      print('API 호출 에러:');
      print(e);
      print(stack);
      timetableProvider.setError('네트워크 오류');
      timetableProvider.setLoading(false);
    }
  }

  List<String> _convertUnavailableTimes(List<List<bool>> unavailable) {
    // 22행(9:00~19:00, 30분 단위), 5열(월~금)
    const days = ['월', '화', '수', '목', '금'];
    const timeSlots = [
      '09:00~09:30',
      '09:30~10:00',
      '10:00~10:30',
      '10:30~11:00',
      '11:00~11:30',
      '11:30~12:00',
      '12:00~12:30',
      '12:30~13:00',
      '13:00~13:30',
      '13:30~14:00',
      '14:00~14:30',
      '14:30~15:00',
      '15:00~15:30',
      '15:30~16:00',
      '16:00~16:30',
      '16:30~17:00',
      '17:00~17:30',
      '17:30~18:00',
      '18:00~18:30',
      '18:30~19:00',
      '19:00~19:30',
      '19:30~20:00'
    ];
    List<String> result = [];
    for (int row = 0; row < unavailable.length; row++) {
      for (int col = 0; col < unavailable[row].length; col++) {
        if (unavailable[row][col]) {
          result.add('${days[col]} ${timeSlots[row]}');
        }
      }
    }
    // 연속된 시간대는 하나로 합치지 않고, 선택된 모든 칸을 개별적으로 반환
    return result;
  }

  List<Map<String, dynamic>> _parseTimetableResult(dynamic data) {
    print('API 응답 데이터: $data');
    if (data is Map && data['timetables'] is List) {
      print('timetables: ${data['timetables']}');
      // 2차원 배열(flatten)
      final list = data['timetables'] as List;
      return list
          .expand((e) => e is List ? e : [e])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    if (data is List) {
      print('data가 List: $data');
      // 2차원 배열(flatten)
      return data
          .expand((e) => e is List ? e : [e])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    print('파싱 실패, 빈 배열 반환');
    return [];
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
          onComplete: () => _onTestComplete(context),
        );
      case 12:
        return TimetableResultScreen(onRestartSurvey: _goToIntro);
      default:
        return TimetableIntro(onStartSurvey: _goToQ1);
    }
  }
}
