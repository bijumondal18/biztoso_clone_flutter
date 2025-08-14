import 'package:biztoso/data/models/user.dart';

class ConnectionReceivedResponse {
  String? message;
  List<User>? users;

  ConnectionReceivedResponse({this.message, this.users});

  ConnectionReceivedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}