import 'package:dio/dio.dart';
import 'api_client.dart';
import 'package:flutter/material.dart';

class Course {
  final String id;
  final String name;
  final int credits;
  final int practiceCredits;
  final String recommendedSemester;
  final String type;
  final String mandatory;
  final List<Lecture> lectures;

  Course({
    required this.id,
    required this.name,
    required this.credits,
    required this.practiceCredits,
    required this.recommendedSemester,
    required this.type,
    required this.mandatory,
    required this.lectures,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      credits: json['credits'] ?? 0,
      practiceCredits: json['practiceCredits'] ?? 0,
      recommendedSemester: json['recommendedSemester'] ?? '',
      type: json['type'] ?? '',
      mandatory: json['mandatory'] ?? '',
      lectures: (json['lectures'] as List<dynamic>? ?? [])
          .map((e) => Lecture.fromJson(e))
          .toList(),
    );
  }
}

class Lecture {
  final String id;
  final String professor;
  final String classId;
  final String target;
  final String lectureType;
  final String courseId;
  final String time;

  Lecture({
    required this.id,
    required this.professor,
    required this.classId,
    required this.target,
    required this.lectureType,
    required this.courseId,
    required this.time,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'] ?? '',
      professor: json['professor'] ?? '',
      classId: json['classId'] ?? '',
      target: json['target'] ?? '',
      lectureType: json['lectureType'] ?? '',
      courseId: json['courseId'] ?? '',
      time: json['time'] ?? '',
    );
  }
}

class LectureApi {
  static Future<List<Lecture>> fetchLectures() async {
    try {
      final response = await ApiClient.dio.get('/lectures');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          return data.map((e) => Lecture.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  void setCourses(List<Course> newCourses) {
    _courses = newCourses;
    notifyListeners();
  }

  // 필요시 서버에서 불러오는 fetchCourses 등도 추가 가능
}
