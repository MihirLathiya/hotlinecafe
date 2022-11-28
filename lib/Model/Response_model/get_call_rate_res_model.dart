// To parse this JSON data, do
//
//     final getCallRateResponseModel = getCallRateResponseModelFromJson(jsonString);

import 'dart:convert';

GetCallRateResponseModel getCallRateResponseModelFromJson(String str) =>
    GetCallRateResponseModel.fromJson(json.decode(str));

String getCallRateResponseModelToJson(GetCallRateResponseModel data) =>
    json.encode(data.toJson());

class GetCallRateResponseModel {
  GetCallRateResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory GetCallRateResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCallRateResponseModel(
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
    this.ratePerMinit,
  });

  String? ratePerMinit;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ratePerMinit: json["rate_per_minit"],
      );

  Map<String, dynamic> toJson() => {
        "rate_per_minit": ratePerMinit,
      };
}
