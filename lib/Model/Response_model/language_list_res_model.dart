// To parse this JSON data, do
//
//     final languageListResponseModel = languageListResponseModelFromJson(jsonString);

import 'dart:convert';

LanguageListResponseModel languageListResponseModelFromJson(String str) =>
    LanguageListResponseModel.fromJson(json.decode(str));

String languageListResponseModelToJson(LanguageListResponseModel data) =>
    json.encode(data.toJson());

class LanguageListResponseModel {
  LanguageListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory LanguageListResponseModel.fromJson(Map<String, dynamic> json) =>
      LanguageListResponseModel(
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
    this.language,
  });

  String? language;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
      };
}
