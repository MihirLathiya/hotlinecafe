// To parse this JSON data, do
//
//     final followResponseModel = followResponseModelFromJson(jsonString);

import 'dart:convert';

FollowResponseModel followResponseModelFromJson(String str) =>
    FollowResponseModel.fromJson(json.decode(str));

String followResponseModelToJson(FollowResponseModel data) =>
    json.encode(data.toJson());

class FollowResponseModel {
  FollowResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory FollowResponseModel.fromJson(Map<String, dynamic> json) =>
      FollowResponseModel(
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
