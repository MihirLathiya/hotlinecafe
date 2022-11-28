// To parse this JSON data, do
//
//     final regionListResponseModel = regionListResponseModelFromJson(jsonString);

import 'dart:convert';

RegionListResponseModel regionListResponseModelFromJson(String str) =>
    RegionListResponseModel.fromJson(json.decode(str));

String regionListResponseModelToJson(RegionListResponseModel data) =>
    json.encode(data.toJson());

class RegionListResponseModel {
  RegionListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory RegionListResponseModel.fromJson(Map<String, dynamic> json) =>
      RegionListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.name,
    this.flag,
  });

  String? name;
  String? flag;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "flag": flag,
      };
}
