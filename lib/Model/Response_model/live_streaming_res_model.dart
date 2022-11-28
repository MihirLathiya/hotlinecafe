// To parse this JSON data, do
//
//     final liveStreamingResponseModel = liveStreamingResponseModelFromJson(jsonString);

import 'dart:convert';

LiveStreamingResponseModel liveStreamingResponseModelFromJson(String str) =>
    LiveStreamingResponseModel.fromJson(json.decode(str));

String liveStreamingResponseModelToJson(LiveStreamingResponseModel data) =>
    json.encode(data.toJson());

class LiveStreamingResponseModel {
  LiveStreamingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory LiveStreamingResponseModel.fromJson(Map<String, dynamic> json) =>
      LiveStreamingResponseModel(
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
