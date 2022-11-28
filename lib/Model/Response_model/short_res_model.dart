// To parse this JSON data, do
//
//     final shortResponseModel = shortResponseModelFromJson(jsonString);

import 'dart:convert';

ShortResponseModel shortResponseModelFromJson(String str) =>
    ShortResponseModel.fromJson(json.decode(str));

String shortResponseModelToJson(ShortResponseModel data) =>
    json.encode(data.toJson());

class ShortResponseModel {
  ShortResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory ShortResponseModel.fromJson(Map<String, dynamic> json) =>
      ShortResponseModel(
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
