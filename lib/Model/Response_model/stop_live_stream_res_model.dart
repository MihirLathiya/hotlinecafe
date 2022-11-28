// To parse this JSON data, do
//
//     final stopLiveStreamingResponseModel = stopLiveStreamingResponseModelFromJson(jsonString);

import 'dart:convert';

StopLiveStreamingResponseModel stopLiveStreamingResponseModelFromJson(
        String str) =>
    StopLiveStreamingResponseModel.fromJson(json.decode(str));

String stopLiveStreamingResponseModelToJson(
        StopLiveStreamingResponseModel data) =>
    json.encode(data.toJson());

class StopLiveStreamingResponseModel {
  StopLiveStreamingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<dynamic>? data;

  factory StopLiveStreamingResponseModel.fromJson(Map<String, dynamic> json) =>
      StopLiveStreamingResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x)),
      };
}
