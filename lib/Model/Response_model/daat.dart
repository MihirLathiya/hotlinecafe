// To parse this JSON data, do
//
//     final agoraTokenResponseModel = agoraTokenResponseModelFromJson(jsonString);

import 'dart:convert';

AgoraTokenResponseModel agoraTokenResponseModelFromJson(String str) =>
    AgoraTokenResponseModel.fromJson(json.decode(str));

String agoraTokenResponseModelToJson(AgoraTokenResponseModel data) =>
    json.encode(data.toJson());

class AgoraTokenResponseModel {
  AgoraTokenResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AgoraTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      AgoraTokenResponseModel(
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
    this.channelName,
    this.token,
  });

  String? channelName;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        channelName: json["channelName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "channelName": channelName,
        "token": token,
      };
}
