
import 'package:biztoso/data/models/user.dart';

class ConnectionResponse {
  dynamic message;
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

  ConnectionResponse copyWith({
    dynamic message,
    Connections? users,
  }) {
    return ConnectionResponse(
      message: message ?? this.message,
      users: users ?? this.users,
    );
  }
}

class Connections {
  List<User>? docs;
  dynamic totalDocs;
  dynamic limit;
  dynamic page;
  dynamic totalPages;
  dynamic pagingCounter;
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

  Connections copyWith({
    List<User>? docs,
    dynamic totalDocs,
    dynamic limit,
    dynamic page,
    dynamic totalPages,
    dynamic pagingCounter,
    bool? hasPrevPage,
    bool? hasNextPage,
    dynamic prevPage,
    dynamic nextPage,
  }) {
    return Connections(
      docs: docs ?? this.docs,
      totalDocs: totalDocs ?? this.totalDocs,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      pagingCounter: pagingCounter ?? this.pagingCounter,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      prevPage: prevPage ?? this.prevPage,
      nextPage: nextPage ?? this.nextPage,
    );
  }
}