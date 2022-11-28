class SignUpRequestModel {
  String? name;
  String? username;
  String? mobileNo;
  String? password;

  SignUpRequestModel({this.name, this.username, this.mobileNo, this.password});

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    mobileNo = json['mobile_no'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['mobile_no'] = this.mobileNo;
    data['password'] = this.password;
    return data;
  }
}
