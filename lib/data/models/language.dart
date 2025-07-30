import 'dart:ui';

import 'package:biztoso/core/resources/app_images.dart';

class Language {
  final String imagePath;
  final String title;
  final String subTitle;
  final Color bgColor;
  bool isSelected;

  Language(
    this.imagePath,
    this.title,
    this.subTitle,
    this.bgColor,
    this.isSelected,
  );
}

final List<Language> languageList = [
  Language(AppImages.imgEnglish, '', 'English', Color(0xFFE5F1F3), true),
  Language(AppImages.imgHindi, 'हिंदी', 'Hindi', Color(0xFFEFE5F7), false),
  Language(AppImages.imgKannada, 'ಕನ್ನಡ', 'Kannada', Color(0xFFE7F0F8), false),
];
