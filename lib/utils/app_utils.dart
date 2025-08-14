import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppUtils{

  static void showDebugLog(String tag, dynamic message) {
    if (kDebugMode) {
      if (message is Map || message is List) {
        log("[$tag] ${const JsonEncoder.withIndent('  ').convert(message)}");
      } else {
        log("[$tag] $message");
      }
    }
  }
}