// To parse this JSON data, do
//
//     final randomMatchOnOffResponseModel = randomMatchOnOffResponseModelFromJson(jsonString);

import 'dart:convert';

RandomMatchOnOffResponseModel randomMatchOnOffResponseModelFromJson(
        String str) =>
    RandomMatchOnOffResponseModel.fromJson(json.decode(str));

String randomMatchOnOffResponseModelToJson(
        RandomMatchOnOffResponseModel data) =>
    json.encode(data.toJson());

class RandomMatchOnOffResponseModel {
  RandomMatchOnOffResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory RandomMatchOnOffResponseModel.fromJson(Map<String, dynamic> json) =>
      RandomMatchOnOffResponseModel(
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
    this.token,
    this.channelName,
  });

  String? token;
  String? channelName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        channelName: json["channelName"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "channelName": channelName,
      };
}
