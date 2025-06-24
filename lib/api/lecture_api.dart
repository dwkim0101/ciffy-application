import 'package:dio/dio.dart';
import 'api_client.dart';

class LectureApi {
  static Future<List<Map<String, dynamic>>> fetchLectures() async {
    try {
      final response = await ApiClient.dio.get('/lectures');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
