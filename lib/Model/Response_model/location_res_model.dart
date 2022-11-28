// To parse this JSON data, do
//
//     final locationResponseModel = locationResponseModelFromJson(jsonString);

import 'dart:convert';

LocationResponseModel locationResponseModelFromJson(String str) =>
    LocationResponseModel.fromJson(json.decode(str));

String locationResponseModelToJson(LocationResponseModel data) =>
    json.encode(data.toJson());

class LocationResponseModel {
  LocationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) =>
      LocationResponseModel(
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
