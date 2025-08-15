import 'package:biztoso/data/models/user.dart';

class ChatListResponse {
  bool? success;
  List<Chats>? chats;

  ChatListResponse({this.success, this.chats});

  ChatListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = this.success;
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String? sId;
  String? lastMessage;
  String? lastMessageAt;
  String? lastMessageId;
  int? unreadMessagesCount;
  String? pinnedMessage;
  dynamic pinnedMessageId;
  User? user;
  bool? isOnline;
  String? lastUnreadMessageId;

  Chats(
      {this.sId,
        this.lastMessage,
        this.lastMessageAt,
        this.lastMessageId,
        this.unreadMessagesCount,
        this.pinnedMessage,
        this.pinnedMessageId,
        this.user,
        this.isOnline,
        this.lastUnreadMessageId});

  Chats.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lastMessage = json['lastMessage'];
    lastMessageAt = json['lastMessageAt'];
    lastMessageId = json['lastMessageId'];
    unreadMessagesCount = json['unreadMessagesCount'];
    pinnedMessage = json['pinnedMessage'];
    pinnedMessageId = json['pinnedMessageId'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    isOnline = json['isOnline'];
    lastUnreadMessageId = json['lastUnreadMessageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageAt'] = this.lastMessageAt;
    data['lastMessageId'] = this.lastMessageId;
    data['unreadMessagesCount'] = this.unreadMessagesCount;
    data['pinnedMessage'] = this.pinnedMessage;
    data['pinnedMessageId'] = this.pinnedMessageId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['isOnline'] = this.isOnline;
    data['lastUnreadMessageId'] = this.lastUnreadMessageId;
    return data;
  }
}
