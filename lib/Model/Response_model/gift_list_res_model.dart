// To parse this JSON data, do
//
//     final giftListResponseModel = giftListResponseModelFromJson(jsonString);

import 'dart:convert';

GiftListResponseModel giftListResponseModelFromJson(String str) =>
    GiftListResponseModel.fromJson(json.decode(str));

String giftListResponseModelToJson(GiftListResponseModel data) =>
    json.encode(data.toJson());

class GiftListResponseModel {
  GiftListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory GiftListResponseModel.fromJson(Map<String, dynamic> json) =>
      GiftListResponseModel(
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
