// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) => UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) => json.encode(data.toJson());

class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String ?status;
  String? message;
  Data ?data;

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) => UpdateProfileResponseModel(
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
    this.deviceId,
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
  String ?lattitude;
  String? longitude;
  String? isLive;
  String? random;
  String? earnings;
  String? deviceId;

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
    deviceId: json["device_id"],
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
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "otp": otp,
    "registration_date": "${registrationDate!.year.toString().padLeft(4, '0')}-${registrationDate!.month.toString().padLeft(2, '0')}-${registrationDate!.day.toString().padLeft(2, '0')}",
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
    "device_id": deviceId,
  };
}
