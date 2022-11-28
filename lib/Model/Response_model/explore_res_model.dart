// To parse this JSON data, do
//
//     final exploreResponseModel = exploreResponseModelFromJson(jsonString);

import 'dart:convert';

ExploreResponseModel exploreResponseModelFromJson(String str) =>
    ExploreResponseModel.fromJson(json.decode(str));

String exploreResponseModelToJson(ExploreResponseModel data) =>
    json.encode(data.toJson());

class ExploreResponseModel {
  ExploreResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory ExploreResponseModel.fromJson(Map<String, dynamic> json) =>
      ExploreResponseModel(
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
    this.all,
    this.popular,
    this.live,
    this.vs,
    this.nearBy,
    this.dataNew,
  });

  List<All>? all;
  List<All>? popular;
  List<All>? live;
  List<V>? vs;
  List<All>? nearBy;
  List<All>? dataNew;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        all: List<All>.from(json["all"].map((x) => All.fromJson(x))),
        popular: List<All>.from(json["popular"].map((x) => All.fromJson(x))),
        live: List<All>.from(json["live"].map((x) => All.fromJson(x))),
        vs: List<V>.from(json["vs"].map((x) => V.fromJson(x))),
        nearBy: List<All>.from(json["near_by"].map((x) => All.fromJson(x))),
        dataNew: List<All>.from(json["new"].map((x) => All.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all": List<dynamic>.from(all!.map((x) => x.toJson())),
        "popular": List<dynamic>.from(popular!.map((x) => x.toJson())),
        "live": List<dynamic>.from(live!.map((x) => x.toJson())),
        "vs": List<dynamic>.from(vs!.map((x) => x.toJson())),
        "near_by": List<dynamic>.from(nearBy!.map((x) => x.toJson())),
        "new": List<dynamic>.from(dataNew!.map((x) => x.toJson())),
      };
}

class All {
  All({
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

  factory All.fromJson(Map<String, dynamic> json) => All(
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

class V {
  V({
    this.fromData,
    this.toData,
  });

  All? fromData;
  All? toData;

  factory V.fromJson(Map<String, dynamic> json) => V(
        fromData: All.fromJson(json["from_data"]),
        toData: All.fromJson(json["to_data"]),
      );

  Map<String, dynamic> toJson() => {
        "from_data": fromData!.toJson(),
        "to_data": toData!.toJson(),
      };
}
