import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_constants.dart';

class AuthApi {
  static Future<String?> login(
      {required String id, required String password}) async {
    try {
      final response = await ApiClient.dio.post(
        ApiConstants.login,
        data: {
          'id': id,
          'password': password,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'];
        return data['access_token'] as String?;
      }
      return null;
    } catch (e) {
      // 에러 처리 (로그 등)
      return null;
    }
  }
}
