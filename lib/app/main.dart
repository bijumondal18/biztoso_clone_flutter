import 'package:biztoso/app/biztoso_app.dart';
import 'package:biztoso/core/di/service_locator.dart';
import 'package:biztoso/utils/device_utils.dart';
import 'package:flutter/material.dart';


String? deviceName;
String? deviceId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Dependency Injection
  serviceLocator();

  deviceId = await DeviceUtils.getDeviceId();
  deviceName = await DeviceUtils.getDeviceName();

  /// Starting point of the application
  runApp(BiztosoApp());
}
