import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppUtils {
  static void showDebugLog(String tag, dynamic message) {
    if (kDebugMode) {
      if (message is Map || message is List) {
        log("[$tag] ${const JsonEncoder.withIndent('  ').convert(message)}");
      } else {
        log("[$tag] $message");
      }
    }
  }

  static String firstNonEmptyTitle(
    List<Object?> values, {
    String fallback = 'N/A',
  }) {
    for (final v in values) {
      final s = v?.toString().trim() ?? '';
      if (s.isNotEmpty) return toTitleCase(s);
    }
    return fallback;
  }

  // Handles words, hyphenated names (Mary-Jane), and O'Brien
  static String toTitleCase(String input) {
    return input
        .trim()
        .split(RegExp(r'\s+'))
        .map(
          (word) => word
              .split(RegExp(r"([-'])")) // keep separators
              .map((part) {
                if (part == '-' || part == "'") return part;
                if (part.isEmpty) return part;
                final lower = part.toLowerCase();
                return lower[0].toUpperCase() + lower.substring(1);
              })
              .join(''),
        )
        .join(' ');
  }
}
