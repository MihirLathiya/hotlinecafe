class SocialLoginReqModel {
  String? socialType;
  String? socialId;
  String? deviceId;
  String? name;
  String? email;

  SocialLoginReqModel(
      {this.socialType, this.socialId, this.deviceId, this.name, this.email});

  SocialLoginReqModel.fromJson(Map<String, dynamic> json) {
    socialType = json['social_type'];
    socialId = json['social_id'];
    deviceId = json['device_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['social_type'] = this.socialType;
    data['social_id'] = this.socialId;
    data['device_id'] = this.deviceId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
