// To parse this JSON data, do
//
//     final removeVsLiveResponseModel = removeVsLiveResponseModelFromJson(jsonString);

import 'dart:convert';

RemoveVsLiveResponseModel removeVsLiveResponseModelFromJson(String str) =>
    RemoveVsLiveResponseModel.fromJson(json.decode(str));

String removeVsLiveResponseModelToJson(RemoveVsLiveResponseModel data) =>
    json.encode(data.toJson());

class RemoveVsLiveResponseModel {
  RemoveVsLiveResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory RemoveVsLiveResponseModel.fromJson(Map<String, dynamic> json) =>
      RemoveVsLiveResponseModel(
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
