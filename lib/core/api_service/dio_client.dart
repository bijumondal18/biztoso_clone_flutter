import 'dart:developer';
import 'dart:io';

import 'package:biztoso/core/api_service/end_points.dart';
import 'package:biztoso/core/api_service/token_storage.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:dio/dio.dart';

import '../di/service_locator.dart';
import 'error_handler.dart';
import 'network_interceptor.dart';

typedef NoInternetCallback = void Function();

class DioClient {
  late final Dio _dio;
  final TokenStorage _tokenStorage = sl<TokenStorage>();
  final int _maxRetryAttempts = 2;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(NetworkInterceptor());
    _dio.interceptors.add(_authInterceptor());
  }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokenStorage.readToken();
        if (token?.isNotEmpty ?? false) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        if (options.data is FormData) {
          options.headers.remove('Content-Type');
        }

        AppUtils.showDebugLog(options.method, options.uri);
        if (options.data != null) {
          AppUtils.showDebugLog("Request", options.data);
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        AppUtils.showDebugLog('${response.statusCode}', response.data);
        handler.next(response);
      },
      onError: (DioException error, handler) async {
        final options = error.requestOptions;

        if (_shouldRetry(error)) {
          final retryCount = (options.extra['retries'] as int? ?? 0) + 1;

          if (retryCount <= _maxRetryAttempts) {
            log("🔁 Retrying [${options.uri}]... Attempt #$retryCount");
            options.extra['retries'] = retryCount;
            try {
              final response = await _dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              return handler.reject(e as DioException);
            }
          }
        }

        ErrorHandler.handle(error);
        handler.next(error);
      },
    );
  }

  bool _shouldRetry(DioException e) {
    return e.error is! SocketException &&
        (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.unknown ||
            e.response?.statusCode == 500 ||
            e.response?.statusCode == 503);
  }

  Future<Response?> _request(
    String method,
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    bool isFormData = false,
  }) async {
    try {
      final payload = isFormData ? FormData.fromMap(data ?? {}) : data;

      final response = await _dio.request(
        endpoint,
        data: payload,
        queryParameters: queryParams,
        options: Options(method: method),
      );

      return response;
    } on DioException catch (e) {
      ErrorHandler.handle(e);
      return null;
    }
  }

  Future<Response?> get(String endpoint, {Map<String, dynamic>? queryParams}) =>
      _request('GET', endpoint, queryParams: queryParams);

  Future<Response?> post(
    String endpoint, {
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) => _request('POST', endpoint, data: data, isFormData: isFormData);

  Future<Response?> put(
    String endpoint, {
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) => _request('PUT', endpoint, data: data, isFormData: isFormData);

  Future<Response?> delete(
    String endpoint, {
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) => _request('DELETE', endpoint, data: data, isFormData: isFormData);

  Dio get rawDio => _dio;
}
