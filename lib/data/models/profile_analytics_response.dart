class ProfileAnalyticsResponse {
  String? message;
  Result? result;

  ProfileAnalyticsResponse({this.message, this.result});

  ProfileAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
    json['result'] != null ?  Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? fullName;
  String? email;
  List<String>? improvement;
  int? strength;
  String? profilePic;
  String? businessType;
  int? totalViewOfCurrentWeek;
  int? totalViewByDateRange;
  int? comparedToLastMonth;
  int? searchAppearanceCount;
  List<GeoDistribution>? geoDistribution;

  Result(
      {this.sId,
        this.fullName,
        this.email,
        this.improvement,
        this.strength,
        this.profilePic,
        this.businessType,
        this.totalViewOfCurrentWeek,
        this.totalViewByDateRange,
        this.comparedToLastMonth,
        this.searchAppearanceCount,
        this.geoDistribution});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['FullName'];
    email = json['Email'];
    improvement = json['improvement'].cast<String>();
    strength = json['strength'];
    profilePic = json['ProfilePic'];
    businessType = json['BusinessType'];
    totalViewOfCurrentWeek = json['totalViewOfCurrentWeek'];
    totalViewByDateRange = json['totalViewByDateRange'];
    comparedToLastMonth = json['comparedToLastMonth'];
    searchAppearanceCount = json['searchAppearanceCount'];
    if (json['geoDistribution'] != null) {
      geoDistribution = <GeoDistribution>[];
      json['geoDistribution'].forEach((v) {
        geoDistribution!.add( GeoDistribution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['FullName'] = fullName;
    data['Email'] = email;
    data['improvement'] = improvement;
    data['strength'] = strength;
    data['ProfilePic'] = profilePic;
    data['BusinessType'] = businessType;
    data['totalViewOfCurrentWeek'] = totalViewOfCurrentWeek;
    data['totalViewByDateRange'] = totalViewByDateRange;
    data['comparedToLastMonth'] = comparedToLastMonth;
    data['searchAppearanceCount'] = searchAppearanceCount;
    if (geoDistribution != null) {
      data['geoDistribution'] =
          geoDistribution!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeoDistribution {
  String? state;
  String? percentage;

  GeoDistribution({this.state, this.percentage});

  GeoDistribution.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['state'] = state;
    data['percentage'] = percentage;
    return data;
  }
}