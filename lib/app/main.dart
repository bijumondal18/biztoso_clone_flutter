import 'package:biztoso/app/biztoso_app.dart';
import 'package:biztoso/core/di/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Dependency Injection
  serviceLocator();

  /// Starting point of the application
  runApp(BiztosoApp());
}
