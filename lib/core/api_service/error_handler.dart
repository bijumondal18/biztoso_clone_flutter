import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class ErrorHandler {
  static void handle(DioException error) {
    if (error.error is SocketException) {
      log("❌ No Internet Connection");
      return;
    }
    if (error.type == DioExceptionType.connectionTimeout) {
      log("⚠️ Connection timeout");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      log("⚠️ Receive timeout");
    } else if (error.type == DioExceptionType.badResponse) {
      log("⚠️ Server error: ${error.response?.statusCode} => ${error.response?.data}");
    } else if (error.type == DioExceptionType.unknown) {
      log("⚠️ Unknown error: ${error.message}");
    } else {
      log("⚠️ Dio error: ${error.message}");
    }
  }
}