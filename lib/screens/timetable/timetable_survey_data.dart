class TimeTableSurveyData {
  // Q1: 사전 신청 강좌
  List<Map<String, String?>> preAppliedLectures;
  // Q2: 수강 불가능 시간
  List<List<bool>> unavailableTimes;
  // TODO: Q3~Q10 데이터 필드 추가

  TimeTableSurveyData({
    List<Map<String, String?>>? preAppliedLectures,
    List<List<bool>>? unavailableTimes,
  })  : preAppliedLectures = preAppliedLectures ?? [],
        unavailableTimes =
            unavailableTimes ?? List.generate(19, (_) => List.filled(5, false));

  // 필요시 toJson/fromJson 등 추가
}
