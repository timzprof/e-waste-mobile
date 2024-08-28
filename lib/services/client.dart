import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

final client = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL']!,
    headers: {'Content-Type': 'application/json'}))
  ..interceptors.add(InterceptorsWrapper(
    onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ));

void handleAPIError(DioException error) {
  print("[API Error]: ${error.response}");
  print("[API Error]: Message: ${error.response?.data['message']}");
  throw error.response != null && error.response?.data['errorMessage'] != null
      ? error.response?.data['errorMessage']
      : error.response != null && error.response?.data['errorMessage'] != null
          ? error.response?.data['message']
          : error;
}
