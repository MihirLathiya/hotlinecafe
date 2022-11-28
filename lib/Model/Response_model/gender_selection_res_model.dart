// To parse this JSON data, do
//
//     final genderSelectionResponseModel = genderSelectionResponseModelFromJson(jsonString);

import 'dart:convert';

GenderSelectionResponseModel genderSelectionResponseModelFromJson(String str) =>
    GenderSelectionResponseModel.fromJson(json.decode(str));

String genderSelectionResponseModelToJson(GenderSelectionResponseModel data) =>
    json.encode(data.toJson());

class GenderSelectionResponseModel {
  GenderSelectionResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory GenderSelectionResponseModel.fromJson(Map<String, dynamic> json) =>
      GenderSelectionResponseModel(
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
    this.name,
    this.username,
    this.mobileNo,
    this.password,
    this.gender,
    this.dob,
    this.otp,
    this.registrationDate,
  });

  String? userId;
  String? name;
  String? username;
  String? mobileNo;
  String? password;
  String? gender;
  DateTime? dob;
  String? otp;
  DateTime? registrationDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
        username: json["username"],
        mobileNo: json["mobile_no"],
        password: json["password"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        otp: json["otp"],
        registrationDate: DateTime.parse(json["registration_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
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
      };
}
