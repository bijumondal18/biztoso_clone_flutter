import 'dart:math';
import 'package:flutter/material.dart';

class AppColors {
  static const primaryDark = Color(0xFF1135FF);
  static const primaryLight = Color(0xFF0520D3);

  static const ctaPrimary = Color(0xFFED764F);

  static const labelPrimary = Color(0xFF000000);
  static const labelSecondary = Color(0xFF616161);

  static const shadowDark = Color(0xFF1F1F1F);
  static const shadowLight = Color(0xE2E8E8E8);

  static const canvasLight = Color(0xFFD0D0D0);
  static const canvasDark = Color(0xFF333333);

  static const scaffoldBackgroundLight = Color(0xFFFFFFFF);
  static const scaffoldBackgroundDark = Color(0xFF121212);

  static const textFieldLight = Color(0xFFF1FAF0);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF121212);

  static const darkGrey = Color(0xFF383838);
  static const grey = Color(0xFF696969);

  static const cardDark = Color(0xFF1A1A1A);
  static const cardLight = Color(0xFFFFFFFF);

  static const dividerLight = Color(0xFFE1E1E1);
  static const dividerDark = Color(0xFF363636);

  static const hintLight = Color(0xFF878787);
  static const hintDark = Color(0xFFA2A2A2);

  static const errorDark = Color(0xFF8D2222);
  static const errorLight = Color(0xFFDC4949);

  static const red = Color(0xFFEA1B1B);

  static const lightColor1 = Color(0xFFE4EDFF);
  static const lightColor2 = Color(0xFFFBEDFF);
  static const lightColor3 = Color(0xFFDFF0FF);

  static const gradientOne = Color(0xFF0021FF);
  static const gradientThree = Color(0xFF8F6CF1);
  static const gradientTwo = Color(0xFF7342FF);

  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      gradientTwo,
      gradientOne,
    ],
  );

  static const secondaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.canvasLight,
      AppColors.canvasDark,
    ],
  );

  static const errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [errorDark, errorLight],
  );

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1,
  );

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1,
  );
}
