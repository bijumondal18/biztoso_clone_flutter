
import 'package:biztoso/data/models/user.dart';

class ConnectionResponse {
  String? message;
  Connections? users;

  ConnectionResponse({this.message, this.users});

  ConnectionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    users = json['users'] != null ?  Connections.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Connections {
  List<User>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  Connections(
      {this.docs,
        this.totalDocs,
        this.limit,
        this.page,
        this.totalPages,
        this.pagingCounter,
        this.hasPrevPage,
        this.hasNextPage,
        this.prevPage,
        this.nextPage});

  Connections.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <User>[];
      json['docs'].forEach((v) {
        docs!.add(new User.fromJson(v));
      });
    }
    totalDocs = json['totalDocs'];
    limit = json['limit'];
    page = json['page'];
    totalPages = json['totalPages'];
    pagingCounter = json['pagingCounter'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prevPage = json['prevPage'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['totalDocs'] = this.totalDocs;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalPages'] = this.totalPages;
    data['pagingCounter'] = this.pagingCounter;
    data['hasPrevPage'] = this.hasPrevPage;
    data['hasNextPage'] = this.hasNextPage;
    data['prevPage'] = this.prevPage;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

// class Docs {
//   String? sId;
//   String? userId;
//   int? gender;
//   String? userName;
//   String? name;
//   String? businessName;
//   String? email;
//   String? address;
//   String? profilePic;
//
//   Docs(
//       {this.sId,
//         this.userId,
//         this.gender,
//         this.userName,
//         this.name,
//         this.businessName,
//         this.email,
//         this.address,
//         this.profilePic});
//
//   Docs.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userId = json['userId'];
//     gender = json['gender'];
//     userName = json['user_name'];
//     name = json['name'];
//     businessName = json['business_name'];
//     email = json['email'];
//     address = json['address'];
//     profilePic = json['profile_pic'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['_id'] = this.sId;
//     data['userId'] = this.userId;
//     data['gender'] = this.gender;
//     data['user_name'] = this.userName;
//     data['name'] = this.name;
//     data['business_name'] = this.businessName;
//     data['email'] = this.email;
//     data['address'] = this.address;
//     data['profile_pic'] = this.profilePic;
//     return data;
//   }
// }