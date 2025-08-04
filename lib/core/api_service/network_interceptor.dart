import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef NoInternetCallback = void Function(BuildContext context);

class NetworkInterceptor extends Interceptor {
  final NoInternetCallback onNoInternet;

  NetworkInterceptor({required this.onNoInternet});

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // 👇 Extract context from options.extra
      final context = options.extra['context'] as BuildContext?;

      if (context != null) {
        onNoInternet(context);
      }

      return handler.reject(
        DioException(
          requestOptions: options,
          error: SocketException('No internet connection'),
          type: DioExceptionType.unknown,
        ),
      );
    }

    handler.next(options);
  }
}
