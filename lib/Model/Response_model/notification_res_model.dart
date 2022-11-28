// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) =>
    NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) =>
    json.encode(data.toJson());

class NotificationResponseModel {
  NotificationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
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
    this.id,
    this.notification,
    this.status,
    this.profilePic,
    this.entryDate,
    this.entryDateTime,
  });

  String? id;
  String? notification;
  String? status;
  String? profilePic;
  DateTime? entryDate;
  DateTime? entryDateTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        notification: json["notification"],
        status: json["status"],
        profilePic: json["profile_pic"],
        entryDate: DateTime.parse(json["entry_date"]),
        entryDateTime: DateTime.parse(json["entry_date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notification": notification,
        "status": status,
        "profile_pic": profilePic,
        "entry_date":
            "${entryDate!.year.toString().padLeft(4, '0')}-${entryDate!.month.toString().padLeft(2, '0')}-${entryDate!.day.toString().padLeft(2, '0')}",
        "entry_date_time": entryDateTime!.toIso8601String(),
      };
}
