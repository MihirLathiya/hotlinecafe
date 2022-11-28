// To parse this JSON data, do
//
//     final giftHistoryResponseModel = giftHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

GiftHistoryResponseModel giftHistoryResponseModelFromJson(String str) =>
    GiftHistoryResponseModel.fromJson(json.decode(str));

String giftHistoryResponseModelToJson(GiftHistoryResponseModel data) =>
    json.encode(data.toJson());

class GiftHistoryResponseModel {
  GiftHistoryResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory GiftHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      GiftHistoryResponseModel(
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
    this.giftId,
    this.title,
    this.image,
    this.coins,
  });

  String? giftId;
  String? title;
  String? image;
  String? coins;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        giftId: json["gift_id "],
        title: json["title "],
        image: json["image"],
        coins: json["coins "],
      );

  Map<String, dynamic> toJson() => {
        "gift_id ": giftId,
        "title ": title,
        "image": image,
        "coins ": coins,
      };
}
