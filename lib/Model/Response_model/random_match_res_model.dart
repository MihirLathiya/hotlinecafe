// To parse this JSON data, do
//
//     final randomMatchResponseModel = randomMatchResponseModelFromJson(jsonString);

import 'dart:convert';

RandomMatchResponseModel randomMatchResponseModelFromJson(String str) =>
    RandomMatchResponseModel.fromJson(json.decode(str));

String randomMatchResponseModelToJson(RandomMatchResponseModel data) =>
    json.encode(data.toJson());

class RandomMatchResponseModel {
  RandomMatchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory RandomMatchResponseModel.fromJson(Map<String, dynamic> json) =>
      RandomMatchResponseModel(
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
    this.channelName,
    this.token,
    this.userId,
    this.name,
    this.username,
    this.isLive,
    this.profilePic,
    this.follower,
    this.view,
  });

  String? channelName;
  String? token;
  String? userId;
  String? name;
  String? username;
  String? isLive;
  String? profilePic;
  int? follower;
  String? view;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        channelName: json["channelName"],
        token: json["token"],
        userId: json["user_id"],
        name: json["name"],
        username: json["username"],
        isLive: json["is_live"],
        profilePic: json["profile_pic"],
        follower: json["follower"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "channelName": channelName,
        "token": token,
        "user_id": userId,
        "name": name,
        "username": username,
        "is_live": isLive,
        "profile_pic": profilePic,
        "follower": follower,
        "view": view,
      };
}
