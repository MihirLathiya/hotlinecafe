// To parse this JSON data, do
//
//     final endCallResponseModel = endCallResponseModelFromJson(jsonString);

import 'dart:convert';

EndCallResponseModel endCallResponseModelFromJson(String str) =>
    EndCallResponseModel.fromJson(json.decode(str));

String endCallResponseModelToJson(EndCallResponseModel data) =>
    json.encode(data.toJson());

class EndCallResponseModel {
  EndCallResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory EndCallResponseModel.fromJson(Map<String, dynamic> json) =>
      EndCallResponseModel(
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
