// To parse this JSON data, do
//
//     final sendGiftResponseModel = sendGiftResponseModelFromJson(jsonString);

import 'dart:convert';

SendGiftResponseModel sendGiftResponseModelFromJson(String str) =>
    SendGiftResponseModel.fromJson(json.decode(str));

String sendGiftResponseModelToJson(SendGiftResponseModel data) =>
    json.encode(data.toJson());

class SendGiftResponseModel {
  SendGiftResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory SendGiftResponseModel.fromJson(Map<String, dynamic> json) =>
      SendGiftResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
