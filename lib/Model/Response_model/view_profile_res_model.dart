// To parse this JSON data, do
//
//     final viewProfileResponseModel = viewProfileResponseModelFromJson(jsonString);

import 'dart:convert';

ViewProfileResponseModel viewProfileResponseModelFromJson(String str) =>
    ViewProfileResponseModel.fromJson(json.decode(str));

String viewProfileResponseModelToJson(ViewProfileResponseModel data) =>
    json.encode(data.toJson());

class ViewProfileResponseModel {
  ViewProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory ViewProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ViewProfileResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.socialType,
    this.socialId,
    this.name,
    this.username,
    this.mobileNo,
    this.password,
    this.gender,
    this.dob,
    this.otp,
    this.registrationDate,
    this.email,
    this.bio,
    this.language,
    this.region,
    this.profilePic,
    this.lattitude,
    this.longitude,
    this.isLive,
    this.random,
    this.earnings,
    this.level,
    this.callRate,
    this.deviceId,
    this.isFollow,
    this.shorts,
    this.balance,
    this.followers,
    this.followings,
  });

  String? userId;
  String? socialType;
  String? socialId;
  String? name;
  String? username;
  String? mobileNo;
  String? password;
  String? gender;
  DateTime? dob;
  String? otp;
  DateTime? registrationDate;
  String? email;
  String? bio;
  String? language;
  String? region;
  String? profilePic;
  String? lattitude;
  String? longitude;
  String? isLive;
  String? random;
  String? earnings;
  String? level;
  String? callRate;
  String? deviceId;
  int? isFollow;
  List<Short>? shorts;
  dynamic balance;
  int? followers;
  int? followings;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        socialType: json["social_type"],
        socialId: json["social_id"],
        name: json["name"],
        username: json["username"],
        mobileNo: json["mobile_no"],
        password: json["password"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        otp: json["otp"],
        registrationDate: DateTime.parse(json["registration_date"]),
        email: json["email"],
        bio: json["bio"],
        language: json["language"],
        region: json["region"],
        profilePic: json["profile_pic"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        isLive: json["is_live"],
        random: json["random"],
        earnings: json["earnings"],
        level: json["level"],
        callRate: json["call_rate"],
        deviceId: json["device_id"],
        isFollow: json["is_follow"],
        shorts: List<Short>.from(json["shorts"].map((x) => Short.fromJson(x))),
        balance: json["balance"],
        followers: json["followers"],
        followings: json["followings"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "social_type": socialType,
        "social_id": socialId,
        "name": name,
        "username": username,
        "mobile_no": mobileNo,
        "password": password,
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "otp": otp,
        "registration_date":
            "${registrationDate!.year.toString().padLeft(4, '0')}-${registrationDate!.month.toString().padLeft(2, '0')}-${registrationDate!.day.toString().padLeft(2, '0')}",
        "email": email,
        "bio": bio,
        "language": language,
        "region": region,
        "profile_pic": profilePic,
        "lattitude": lattitude,
        "longitude": longitude,
        "is_live": isLive,
        "random": random,
        "earnings": earnings,
        "level": level,
        "call_rate": callRate,
        "device_id": deviceId,
        "is_follow": isFollow,
        "shorts": List<dynamic>.from(shorts!.map((x) => x.toJson())),
        "balance": balance,
        "followers": followers,
        "followings": followings,
      };
}

class Short {
  Short({
    this.id,
    this.short,
  });

  String? id;
  String? short;

  factory Short.fromJson(Map<String, dynamic> json) => Short(
        id: json["id"],
        short: json["short"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "short": short,
      };
}
