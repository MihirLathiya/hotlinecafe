// To parse this JSON data, do
//
//     final signUpResponseModel = signUpResponseModelFromJson(jsonString);

import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) =>
    SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) =>
    json.encode(data.toJson());

class SignUpResponseModel {
  SignUpResponseModel({
    this.status,
    this.message,
    this.data,
  });
  String? status;
  String? message;
  Data? data;

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel(
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
    this.mobileNo,
  });

  String? mobileNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mobileNo: json["mobile_no"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_no": mobileNo,
      };
}
