// To parse this JSON data, do
//
//     final addVsLiveResponseModel = addVsLiveResponseModelFromJson(jsonString);

import 'dart:convert';

AddVsLiveResponseModel addVsLiveResponseModelFromJson(String str) =>
    AddVsLiveResponseModel.fromJson(json.decode(str));

String addVsLiveResponseModelToJson(AddVsLiveResponseModel data) =>
    json.encode(data.toJson());

class AddVsLiveResponseModel {
  AddVsLiveResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory AddVsLiveResponseModel.fromJson(Map<String, dynamic> json) =>
      AddVsLiveResponseModel(
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
