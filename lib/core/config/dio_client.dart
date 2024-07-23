import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final _dio = Dio();

  static final _singletonConstructor = DioClient._();

  factory DioClient() {
    return _singletonConstructor;
  }

  DioClient._() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 3)
      ..baseUrl = "https://api.escuelajs.co/api/v1";
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String url,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({required String url}) async {
    try {
      final response = await _dio.delete(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put({
    required String url,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<void> download(String url, String saveDirectory) async {
    final response = await _dio.download(
      url,
      saveDirectory,
      onReceiveProgress: (count, total) {
        debugPrint("${(count / total * 100).toStringAsFixed(0)}%");
      },
    );
  }
}
