import 'dart:ui';

import 'package:biztoso/core/resources/app_images.dart';


class GetLanguage {
  String? message;
  List<Language>? result;

  GetLanguage({this.message, this.result});

  GetLanguage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <Language>[];
      json['result'].forEach((v) {
        result!.add(Language.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Language {
  String? sId;
  String? languageName;
  String? languageCode;
  String? align;
  String? languageNameEnglish;
  String? image;

  Language(
      {this.sId,
        this.languageName,
        this.languageCode,
        this.align,
        this.languageNameEnglish,
        this.image});

  Language.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    languageName = json['language_name'];
    languageCode = json['language_code'];
    align = json['align'];
    languageNameEnglish = json['language_name_english'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['language_name'] = this.languageName;
    data['language_code'] = this.languageCode;
    data['align'] = this.align;
    data['language_name_english'] = this.languageNameEnglish;
    data['image'] = this.image;
    return data;
  }
}
