class UpdateProfileRequestModel {
  String? userId;
  String? name;
  String? username;
  String? bio;
  String? email;
  String? language;
  String? dob;
  String? profilePic;
  String? region;

  UpdateProfileRequestModel(
      {this.userId,
      this.name,
      this.username,
      this.bio,
      this.email,
      this.language,
      this.dob,
      this.profilePic,
      this.region});

  UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    bio = json['bio'];
    email = json['email'];
    language = json['language'];
    dob = json['dob'];
    profilePic = json['profile_pic'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['email'] = this.email;
    data['language'] = this.language;
    data['dob'] = this.dob;
    data['profile_pic'] = this.profilePic;
    data['region'] = this.region;
    return data;
  }
}
