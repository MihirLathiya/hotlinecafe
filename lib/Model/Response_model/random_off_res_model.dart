// To parse this JSON data, do
//
//     final randomMatchOffResponseModel = randomMatchOffResponseModelFromJson(jsonString);

import 'dart:convert';

RandomMatchOffResponseModel randomMatchOffResponseModelFromJson(String str) =>
    RandomMatchOffResponseModel.fromJson(json.decode(str));

String randomMatchOffResponseModelToJson(RandomMatchOffResponseModel data) =>
    json.encode(data.toJson());

class RandomMatchOffResponseModel {
  RandomMatchOffResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<dynamic>? data;

  factory RandomMatchOffResponseModel.fromJson(Map<String, dynamic> json) =>
      RandomMatchOffResponseModel(
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
