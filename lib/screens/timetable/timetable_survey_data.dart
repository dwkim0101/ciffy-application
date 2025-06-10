class TimeTableSurveyData {
  // Q1: 사전 신청 강좌
  List<Map<String, String?>> preAppliedLectures;
  // Q2: 수강 불가능 시간
  List<List<bool>> unavailableTimes;
  // Q3: 꼭 들어야 하는 과목
  List<Map<String, String?>> mustLectures;
  // Q4: 전공 필수 과목 개수
  int majorRequiredCount;
  // Q5: 희망 전공 과목
  List<Map<String, String?>> majorWishLectures;
  // Q6~Q9: 객관식 답변 인덱스
  int q6Answer;
  int q7Answer;
  int q8Answer;
  int q9Answer;
  // Q10: 선호 교수님
  List<String> preferredProfessors;

  TimeTableSurveyData({
    List<Map<String, String?>>? preAppliedLectures,
    List<List<bool>>? unavailableTimes,
    List<Map<String, String?>>? mustLectures,
    int? majorRequiredCount,
    int? q6Answer,
    int? q7Answer,
    int? q8Answer,
    int? q9Answer,
    List<String>? preferredProfessors,
    List<Map<String, String?>>? majorWishLectures,
  })  : preAppliedLectures = preAppliedLectures ?? [],
        unavailableTimes =
            unavailableTimes ?? List.generate(19, (_) => List.filled(5, false)),
        mustLectures = mustLectures ?? [],
        majorWishLectures = majorWishLectures ?? [],
        majorRequiredCount = majorRequiredCount ?? 0,
        q6Answer = q6Answer ?? -1,
        q7Answer = q7Answer ?? -1,
        q8Answer = q8Answer ?? -1,
        q9Answer = q9Answer ?? -1,
        preferredProfessors = preferredProfessors ?? [];

  factory TimeTableSurveyData.fromJson(Map<String, dynamic> json) {
    return TimeTableSurveyData(
      preAppliedLectures: (json['preAppliedLectures'] as List?)
          ?.map((e) => Map<String, String?>.from(e as Map))
          .toList(),
      unavailableTimes: (json['unavailableTimes'] as List?)
          ?.map((e) => List<bool>.from(e as List))
          .toList(),
      mustLectures: (json['mustLectures'] as List?)
          ?.map((e) => Map<String, String?>.from(e as Map))
          .toList(),
      majorRequiredCount: json['majorRequiredCount'] ?? 0,
      q6Answer: json['q6Answer'] ?? -1,
      q7Answer: json['q7Answer'] ?? -1,
      q8Answer: json['q8Answer'] ?? -1,
      q9Answer: json['q9Answer'] ?? -1,
      preferredProfessors: (json['preferredProfessors'] is List)
          ? (json['preferredProfessors'] as List)
              .map((e) => e.toString())
              .toList()
          : [],
      majorWishLectures: (json['majorWishLectures'] is List)
          ? (json['majorWishLectures'] as List)
              .whereType<Map>()
              .map((e) => Map<String, String?>.from(e))
              .toList()
          : [],
    );
  }

  TimeTableSurveyData copyWith({
    List<Map<String, String?>>? preAppliedLectures,
    List<List<bool>>? unavailableTimes,
    List<Map<String, String?>>? mustLectures,
    int? majorRequiredCount,
    int? q6Answer,
    int? q7Answer,
    int? q8Answer,
    int? q9Answer,
    List<String>? preferredProfessors,
    List<Map<String, String?>>? majorWishLectures,
  }) {
    return TimeTableSurveyData(
      preAppliedLectures: preAppliedLectures ?? this.preAppliedLectures,
      unavailableTimes: unavailableTimes ?? this.unavailableTimes,
      mustLectures: mustLectures ?? this.mustLectures,
      majorRequiredCount: majorRequiredCount ?? this.majorRequiredCount,
      q6Answer: q6Answer ?? this.q6Answer ?? -1,
      q7Answer: q7Answer ?? this.q7Answer ?? -1,
      q8Answer: q8Answer ?? this.q8Answer ?? -1,
      q9Answer: q9Answer ?? this.q9Answer ?? -1,
      preferredProfessors: preferredProfessors ?? this.preferredProfessors,
      majorWishLectures: (majorWishLectures != null)
          ? majorWishLectures
          : this.majorWishLectures,
    );
  }

  // 필요시 toJson/fromJson 등 추가
}
