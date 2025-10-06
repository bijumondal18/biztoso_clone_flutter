class User {
  String? sId;
  String? userId;
  String? fullName;
  String? userFullName;
  String? name;
  String? email;
  String? password;
  String? countryCode;
  String? phoneNumber;
  String? refrenceId;
  int? status;
  int? userStatus;
  int? version;
  dynamic deactivatedAt;
  dynamic bannedAt;
  String? profilePic;
  String? profileImage;
  String? preferredLanguage;
  int? signUpType;
  String? coverPhoto;
  String? gST;
  dynamic lockTime;
  int? loginAttempts;
  bool? phoneVerify;
  bool? emailVerify;
  int? userType;
  bool? pushNotification;
  bool? emailNotification;
  bool? smsNotification;
  int? profilePrivacy;
  int? connectionPrivacy;
  int? postPrivacy;
  bool? isOnline;
  bool? lastSeenPrivacy;
  int? shareCount;
  int? twoFactorAuthentication;
  dynamic twoFactorSecret;
  bool? twoFactorMobile;
  String? birthDate;
  String? userName;
  bool? analyticsUse;
  bool? marketingUse;
  bool? rememberMe;
  String? businessType;
  String? businessName;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? age;
  int? userPrivacy;


  User({
    this.sId,
    this.userId,
    this.fullName,
    this.userFullName,
    this.name,
    this.email,
    this.password,
    this.countryCode,
    this.phoneNumber,
    this.refrenceId,
    this.status,
    this.userStatus,
    this.version,
    this.deactivatedAt,
    this.bannedAt,
    this.profilePic,
    this.profileImage,
    this.preferredLanguage,
    this.signUpType,
    this.coverPhoto,
    this.gST,
    this.lockTime,
    this.loginAttempts,
    this.phoneVerify,
    this.emailVerify,
    this.userType,
    this.pushNotification,
    this.emailNotification,
    this.smsNotification,
    this.profilePrivacy,
    this.connectionPrivacy,
    this.postPrivacy,
    this.isOnline,
    this.lastSeenPrivacy,
    this.shareCount,
    this.twoFactorAuthentication,
    this.twoFactorSecret,
    this.twoFactorMobile,
    this.birthDate,
    this.userName,
    this.analyticsUse,
    this.marketingUse,
    this.rememberMe,
    this.businessType,
    this.businessName,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.age,
    this.userPrivacy,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    fullName = json['FullName'];
    userFullName = json['fullName'];
    name = json['name'];
    email = json['Email'];
    password = json['Password'];
    countryCode = json['CountryCode'];
    phoneNumber = json['PhoneNumber'];
    refrenceId = json['RefrenceId'];
    status = json['Status'];
    userStatus = json['userStatus'];
    version = json['version'];
    deactivatedAt = json['deactivatedAt'];
    bannedAt = json['bannedAt'];
    profilePic = json['profile_pic'];
    profileImage = json['profileImage'];
    preferredLanguage = json['preferredLanguage'];
    signUpType = json['SignUpType'];
    coverPhoto = json['CoverPhoto'];
    gST = json['GST'];
    lockTime = json['LockTime'];
    loginAttempts = json['LoginAttempts'];
    phoneVerify = json['phoneVerify'];
    emailVerify = json['emailVerify'];
    userType = json['user_type'];
    pushNotification = json['push_notification'];
    emailNotification = json['email_notification'];
    smsNotification = json['sms_notification'];
    profilePrivacy = json['profilePrivacy'];
    connectionPrivacy = json['connectionPrivacy'];
    postPrivacy = json['postPrivacy'];
    isOnline = json['isOnline'];
    lastSeenPrivacy = json['lastSeenPrivacy'];
    shareCount = json['shareCount'];
    twoFactorAuthentication = json['two_factor_authentication'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorMobile = json['two_factor_mobile'];
    birthDate = json['birth_date'];
    userName = json['user_name'];
    analyticsUse = json['analytics_use'];
    marketingUse = json['marketing_use'];
    rememberMe = json['remember_me'];
    businessType = json['BusinessType'];
    businessName = json['business_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    age = json['age'];
    userPrivacy = json['user_privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['FullName'] = fullName;
    data['fullName'] = userFullName;
    data['name'] = name;
    data['Email'] = email;
    data['Password'] = this.password;
    data['CountryCode'] = this.countryCode;
    data['PhoneNumber'] = this.phoneNumber;
    data['RefrenceId'] = this.refrenceId;
    data['Status'] = this.status;
    data['userStatus'] = this.userStatus;
    data['version'] = this.version;
    data['deactivatedAt'] = this.deactivatedAt;
    data['bannedAt'] = this.bannedAt;
    data['profile_pic'] = this.profilePic;
    data['profileImage'] = this.profileImage;
    data['preferredLanguage'] = this.preferredLanguage;
    data['SignUpType'] = this.signUpType;
    data['CoverPhoto'] = this.coverPhoto;
    data['GST'] = this.gST;
    data['LockTime'] = this.lockTime;
    data['LoginAttempts'] = this.loginAttempts;
    data['phoneVerify'] = this.phoneVerify;
    data['emailVerify'] = this.emailVerify;
    data['user_type'] = this.userType;
    data['push_notification'] = this.pushNotification;
    data['email_notification'] = this.emailNotification;
    data['sms_notification'] = this.smsNotification;
    data['profilePrivacy'] = this.profilePrivacy;
    data['connectionPrivacy'] = this.connectionPrivacy;
    data['postPrivacy'] = this.postPrivacy;
    data['isOnline'] = this.isOnline;
    data['lastSeenPrivacy'] = this.lastSeenPrivacy;
    data['shareCount'] = this.shareCount;
    data['two_factor_authentication'] = this.twoFactorAuthentication;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_mobile'] = this.twoFactorMobile;
    data['birth_date'] = this.birthDate;
    data['user_name'] = this.userName;
    data['analytics_use'] = this.analyticsUse;
    data['marketing_use'] = this.marketingUse;
    data['remember_me'] = this.rememberMe;
    data['BusinessType'] = this.businessType;
    data['business_name'] = this.businessName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['age'] = this.age;
    data['user_privacy'] = this.userPrivacy;
    return data;
  }

}
