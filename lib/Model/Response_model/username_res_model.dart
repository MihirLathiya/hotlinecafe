// To parse this JSON data, do
//
//     final userNameResponseModel = userNameResponseModelFromJson(jsonString);

import 'dart:convert';

UserNameResponseModel userNameResponseModelFromJson(String str) =>
    UserNameResponseModel.fromJson(json.decode(str));

String userNameResponseModelToJson(UserNameResponseModel data) =>
    json.encode(data.toJson());

class UserNameResponseModel {
  UserNameResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory UserNameResponseModel.fromJson(Map<String, dynamic> json) =>
      UserNameResponseModel(
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
    this.profilePic,
    this.lattitude,
    this.longitude,
    this.isLive,
    this.earnings,
    this.deviceId,
    this.isFollow,
    this.shorts,
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
  String? registrationDate;
  String? email;
  String? bio;
  String? language;
  String? profilePic;
  String? lattitude;
  String? longitude;
  String? isLive;
  String? earnings;
  String? deviceId;
  int? isFollow;
  List<Short>? shorts;

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
        registrationDate: json["registration_date"],
        email: json["email"],
        bio: json["bio"],
        language: json["language"],
        profilePic: json["profile_pic"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        isLive: json["is_live"],
        earnings: json["earnings"],
        deviceId: json["device_id"],
        isFollow: json["is_follow"],
        shorts: List<Short>.from(json["shorts"].map((x) => Short.fromJson(x))),
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
        "registration_date": registrationDate,
        "email": email,
        "bio": bio,
        "language": language,
        "profile_pic": profilePic,
        "lattitude": lattitude,
        "longitude": longitude,
        "is_live": isLive,
        "earnings": earnings,
        "device_id": deviceId,
        "is_follow": isFollow,
        "shorts": List<dynamic>.from(shorts!.map((x) => x.toJson())),
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
