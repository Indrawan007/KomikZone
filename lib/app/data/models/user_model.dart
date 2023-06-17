class UserModel {
  String? uid;
  String? name;
  String? email;
  String? createdAt;
  String? lastSignInTime;
  String? photoUrl;
  String? status;
  String? updateAt;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.createdAt,
      this.lastSignInTime,
      this.photoUrl,
      this.status,
      this.updateAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
    lastSignInTime = json['lastSignInTime'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['lastSignInTime'] = lastSignInTime;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['updateAt'] = updateAt;
    return data;
  }
}
