// To parse this JSON data, do
//
//     final verifyOtpResponseModel = verifyOtpResponseModelFromJson(jsonString);

import 'dart:convert';

VerifySignUpOtpResponseModel verifyOtpResponseModelFromJson(String str) =>
    VerifySignUpOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifySignUpOtpResponseModel data) =>
    json.encode(data.toJson());

class VerifySignUpOtpResponseModel {
  VerifySignUpOtpResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory VerifySignUpOtpResponseModel.fromJson(dynamic json) =>
      VerifySignUpOtpResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? {} : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
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
  String? dob;
  String? otp;
  DateTime? registrationDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
        username: json["username"],
        mobileNo: json["mobile_no"],
        password: json["password"],
        gender: json["gender"],
        dob: json["dob"],
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
        "dob": dob,
        "otp": otp,
        "registration_date":
            "${registrationDate!.year.toString().padLeft(4, '0')}-${registrationDate!.month.toString().padLeft(2, '0')}-${registrationDate!.day.toString().padLeft(2, '0')}",
      };
}
