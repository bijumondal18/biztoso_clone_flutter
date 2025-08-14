import 'package:biztoso/data/models/user.dart';

class AllConnectionResponse {
  String? message;
  List<User>? users;

  AllConnectionResponse({this.message, this.users});

  AllConnectionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add( User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
