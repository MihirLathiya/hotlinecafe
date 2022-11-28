// To parse this JSON data, do
//
//     final randomCountResponseModel = randomCountResponseModelFromJson(jsonString);

import 'dart:convert';

RandomCountResponseModel randomCountResponseModelFromJson(String str) =>
    RandomCountResponseModel.fromJson(json.decode(str));

String randomCountResponseModelToJson(RandomCountResponseModel data) =>
    json.encode(data.toJson());

class RandomCountResponseModel {
  RandomCountResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory RandomCountResponseModel.fromJson(Map<String, dynamic> json) =>
      RandomCountResponseModel(
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
    this.count,
  });

  int? count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
