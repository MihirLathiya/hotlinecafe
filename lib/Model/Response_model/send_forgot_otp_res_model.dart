// To parse this JSON data, do
//
//     final sendForgotOtpResponseModel = sendForgotOtpResponseModelFromJson(jsonString);

import 'dart:convert';

SendForgotOtpResponseModel sendForgotOtpResponseModelFromJson(String str) =>
    SendForgotOtpResponseModel.fromJson(json.decode(str));

String sendForgotOtpResponseModelToJson(SendForgotOtpResponseModel data) =>
    json.encode(data.toJson());

class SendForgotOtpResponseModel {
  SendForgotOtpResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory SendForgotOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      SendForgotOtpResponseModel(
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
