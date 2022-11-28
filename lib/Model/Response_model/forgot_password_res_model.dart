// To parse this JSON data, do
//
//     final forgotPasswordResponseModel = forgotPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponseModel forgotPasswordResponseModelFromJson(String str) =>
    ForgotPasswordResponseModel.fromJson(json.decode(str));

String forgotPasswordResponseModelToJson(ForgotPasswordResponseModel data) =>
    json.encode(data.toJson());

class ForgotPasswordResponseModel {
  ForgotPasswordResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
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
