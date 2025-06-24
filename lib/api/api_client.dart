import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
    ),
  );

  static Dio get dio => _dio;
}
