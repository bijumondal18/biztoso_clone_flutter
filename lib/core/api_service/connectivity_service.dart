import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  ConnectivityService._internal() {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final isOffline = results.isNotEmpty && results[0] == ConnectivityResult.none;
      _isOffline.value = isOffline;
    });
  }

  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;

  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  final ValueNotifier<bool> _isOffline = ValueNotifier(false);

  ValueNotifier<bool> get isOffline => _isOffline;

  void dispose() {
    _subscription.cancel();
  }
}