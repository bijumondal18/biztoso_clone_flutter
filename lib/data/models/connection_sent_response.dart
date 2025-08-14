import 'package:biztoso/data/models/user.dart';

class ConnectionSentResponse {
  String? message;
  List<User>? users;

  ConnectionSentResponse({this.message, this.users});

  ConnectionSentResponse.fromJson(Map<String, dynamic> json) {
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

// class Users {
//   String? sId;
//   String? name;
//   String? userName;
//   int? gender;
//   String? businessName;
//   String? profilePic;
//
//   Users(
//       {this.sId,
//         this.name,
//         this.userName,
//         this.gender,
//         this.businessName,
//         this.profilePic});
//
//   Users.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     userName = json['user_name'];
//     gender = json['gender'];
//     businessName = json['business_name'];
//     profilePic = json['profile_pic'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['user_name'] = this.userName;
//     data['gender'] = this.gender;
//     data['business_name'] = this.businessName;
//     data['profile_pic'] = this.profilePic;
//     return data;
//   }
// }