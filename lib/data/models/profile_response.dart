class ProfileResponse {
  String? message;
  Result? result;

  ProfileResponse({this.message, this.result});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? fullName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? profilePic;
  String? preferredLanguage;
  String? coverPhoto;
  String? gST;
  bool? phoneVerify;
  bool? emailVerify;
  bool? pushNotification;
  bool? emailNotification;
  bool? smsNotification;
  bool? lastSeenPrivacy;
  String? birthDate;
  String? userName;
  String? businessType;
  int? age;
  List<Userinfo>? userinfo;
  List<SocialMedia>? socialmedia;
  dynamic connectionFlag;
  dynamic connectionStatus;
  bool? isBlocked;
  List<RequestId>? requestId;
  String? businessName;
  bool? isOnline;
  String? connectionCount;
  String? userPrivacy;
  bool? documentVerify;
  bool? isStore;
  bool? isService;
  bool? isConnectionRequest;

  Result(
      {this.sId,
        this.fullName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.profilePic,
        this.preferredLanguage,
        this.coverPhoto,
        this.gST,
        this.phoneVerify,
        this.emailVerify,
        this.pushNotification,
        this.emailNotification,
        this.smsNotification,
        this.lastSeenPrivacy,
        this.birthDate,
        this.userName,
        this.businessType,
        this.age,
        this.userinfo,
        this.socialmedia,
        this.connectionFlag,
        this.connectionStatus,
        this.isBlocked,
        this.requestId,
        this.businessName,
        this.isOnline,
        this.connectionCount,
        this.userPrivacy,
        this.documentVerify,
        this.isStore,
        this.isService,
        this.isConnectionRequest});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['FullName'];
    email = json['Email'];
    countryCode = json['CountryCode'];
    phoneNumber = json['PhoneNumber'];
    profilePic = json['ProfilePic'];
    preferredLanguage = json['preferredLanguage'];
    coverPhoto = json['CoverPhoto'];
    gST = json['GST'];
    phoneVerify = json['phoneVerify'];
    emailVerify = json['emailVerify'];
    pushNotification = json['push_notification'];
    emailNotification = json['email_notification'];
    smsNotification = json['sms_notification'];
    lastSeenPrivacy = json['lastSeenPrivacy'];
    birthDate = json['birth_date'];
    userName = json['user_name'];
    businessType = json['BusinessType'];
    age = json['age'];
    if (json['userinfo'] != null) {
      userinfo = <Userinfo>[];
      json['userinfo'].forEach((v) {
        userinfo!.add(new Userinfo.fromJson(v));
      });
    }
    if (json['socialmedia'] != null) {
      socialmedia = <SocialMedia>[];
      json['socialmedia'].forEach((v) {
        socialmedia!.add(new SocialMedia.fromJson(v));
      });
    }
    connectionFlag = json['connectionFlag'];
    connectionStatus = json['connectionStatus'];
    isBlocked = json['isBlocked'];
    if (json['requestId'] != null) {
      requestId = <RequestId>[];
      json['requestId'].forEach((v) {
        requestId!.add(new RequestId.fromJson(v));
      });
    }
    businessName = json['business_name'];
    isOnline = json['isOnline'];
    connectionCount = json['connectionCount'];
    userPrivacy = json['user_privacy'];
    documentVerify = json['documentVerify'];
    isStore = json['isStore'];
    isService = json['isService'];
    isConnectionRequest = json['isConnectionRequest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = this.sId;
    data['FullName'] = this.fullName;
    data['Email'] = this.email;
    data['CountryCode'] = this.countryCode;
    data['PhoneNumber'] = this.phoneNumber;
    data['ProfilePic'] = this.profilePic;
    data['preferredLanguage'] = this.preferredLanguage;
    data['CoverPhoto'] = this.coverPhoto;
    data['GST'] = this.gST;
    data['phoneVerify'] = this.phoneVerify;
    data['emailVerify'] = this.emailVerify;
    data['push_notification'] = this.pushNotification;
    data['email_notification'] = this.emailNotification;
    data['sms_notification'] = this.smsNotification;
    data['lastSeenPrivacy'] = this.lastSeenPrivacy;
    data['birth_date'] = this.birthDate;
    data['user_name'] = this.userName;
    data['BusinessType'] = this.businessType;
    data['age'] = this.age;
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo!.map((v) => v.toJson()).toList();
    }
    if (this.socialmedia != null) {
      data['socialmedia'] = this.socialmedia!.map((v) => v.toJson()).toList();
    }
    data['connectionFlag'] = this.connectionFlag;
    data['connectionStatus'] = this.connectionStatus;
    data['isBlocked'] = this.isBlocked;
    if (this.requestId != null) {
      data['requestId'] = this.requestId!.map((v) => v.toJson()).toList();
    }
    data['business_name'] = this.businessName;
    data['isOnline'] = this.isOnline;
    data['connectionCount'] = this.connectionCount;
    data['user_privacy'] = this.userPrivacy;
    data['documentVerify'] = this.documentVerify;
    data['isStore'] = this.isStore;
    data['isService'] = this.isService;
    data['isConnectionRequest'] = this.isConnectionRequest;
    return data;
  }
}

class Userinfo {
  String? flatNumber;
  String? street;
  String? userBio;
  int? zipCode;
  String? city;
  String? country;
  String? state;

  Userinfo(
      {this.flatNumber,
        this.street,
        this.userBio,
        this.zipCode,
        this.city,
        this.country,
        this.state});

  Userinfo.fromJson(Map<String, dynamic> json) {
    flatNumber = json['FlatNumber'];
    street = json['Street'];
    userBio = json['UserBio'];
    zipCode = json['ZipCode'];
    city = json['City'];
    country = json['Country'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FlatNumber'] = this.flatNumber;
    data['Street'] = this.street;
    data['UserBio'] = this.userBio;
    data['ZipCode'] = this.zipCode;
    data['City'] = this.city;
    data['Country'] = this.country;
    data['State'] = this.state;
    return data;
  }
}

class SocialMedia {
  String? sId;
  int? platform;
  String? link;
  String? userId;
  String? createdAt;
  String? updatedAt;

  SocialMedia(
      {this.sId,
        this.platform,
        this.link,
        this.userId,
        this.createdAt,
        this.updatedAt,
       });

  SocialMedia.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    platform = json['platform'];
    link = json['link'];
    userId = json['UserId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = this.sId;
    data['platform'] = this.platform;
    data['link'] = this.link;
    data['UserId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class RequestId {
  String? sId;
  int? status;

  RequestId({this.sId, this.status});

  RequestId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    return data;
  }
}