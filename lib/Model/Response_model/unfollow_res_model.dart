// To parse this JSON data, do
//
//     final unFollowResponseModel = unFollowResponseModelFromJson(jsonString);

import 'dart:convert';

UnFollowResponseModel unFollowResponseModelFromJson(String str) =>
    UnFollowResponseModel.fromJson(json.decode(str));

String unFollowResponseModelToJson(UnFollowResponseModel data) =>
    json.encode(data.toJson());

class UnFollowResponseModel {
  UnFollowResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory UnFollowResponseModel.fromJson(Map<String, dynamic> json) =>
      UnFollowResponseModel(
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
