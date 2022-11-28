// To parse this JSON data, do
//
//     final homeResponseModel = homeResponseModelFromJson(jsonString);

import 'dart:convert';

HomeResponseModel homeResponseModelFromJson(String str) =>
    HomeResponseModel.fromJson(json.decode(str));

String homeResponseModelToJson(HomeResponseModel data) =>
    json.encode(data.toJson());

class HomeResponseModel {
  HomeResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(
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
    this.forYou,
    this.following,
  });

  List<Following>? forYou;
  List<Following>? following;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        forYou: List<Following>.from(
            json["for_you"].map((x) => Following.fromJson(x))),
        following: List<Following>.from(
            json["following"].map((x) => Following.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "for_you": List<dynamic>.from(forYou!.map((x) => x.toJson())),
        "following": List<dynamic>.from(following!.map((x) => x.toJson())),
      };
}

class Following {
  Following({
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

  factory Following.fromJson(Map<String, dynamic> json) => Following(
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
