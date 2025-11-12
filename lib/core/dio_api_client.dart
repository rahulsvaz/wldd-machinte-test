import 'dart:developer';
import 'package:dio/dio.dart';
import 'api_support.dart';

class DioApiClient {
  static final DioApiClient _instance = DioApiClient._internal();
  factory DioApiClient() => _instance;


  final Dio _dio = Dio();

  DioApiClient._internal() {

    _dio.options.baseUrl = ApiSupport.baseUrl;

    _dio.interceptors.add(
      InterceptorsWrapper(

        onRequest: (options, handler) {
          // You can add headers or logging here if needed
          log("Request → [${options.method}] ${options.baseUrl}${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("Response ← [${response.statusCode}] ${response.requestOptions.path}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log("Error ↯ [${e.response?.statusCode}] ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  // API methods
  Future<Response> post(
      String path, {
        required Map<String, dynamic> data,
      }) async {
    try {
      log("POST: $path");
      return await _dio.post(path, data: data);
    } catch (e) {
      log("POST error: $e");
      rethrow;
    }
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      log("GET: $path");
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      log("GET error: $e");
      rethrow;
    }
  }

  Future<Response> put(
      String path, {
        required Map<String, dynamic> data,
      }) async {
    try {
      log("PUT: $path");
      return await _dio.put(path, data: data);
    } catch (e) {
      log("PUT error: $e");
      rethrow;
    }
  }
}
