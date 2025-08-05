import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utils/snackbar_helper.dart';

typedef NoInternetCallback = void Function();

class NetworkInterceptor extends Interceptor {
  bool _isListening = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      SnackBarHelper.show("🚫 No internet. Retrying when back online...");

      if (!_isListening) {
        _isListening = true;

        Connectivity().onConnectivityChanged.listen((status) async {
          if (status != ConnectivityResult.none) {
            SnackBarHelper.show("✅ Internet restored. Retrying request...");

            try {
              final response = await Dio().fetch(options);
              _isListening = false;
              return handler.resolve(response);
            } catch (e) {
              _isListening = false;
              return handler.reject(e as DioException);
            }
          }
        });
      }

      return handler.reject(
        DioException(
          requestOptions: options,
          error: SocketException('No internet connection'),
          type: DioExceptionType.unknown,
        ),
      );
    }

    return handler.next(options);
  }
}
