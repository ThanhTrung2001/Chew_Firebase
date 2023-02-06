class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? avtLink;
  String? status;
  bool? inLive;
  String? description;

  UserModel(this.uid, this.userName, this.email, this.avtLink, this.status,
      this.inLive, this.description);

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['name'];
    email = json['email'];
    avtLink = json['avtLink'];
    status = json['status'];
    inLive = json['inLive'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = userName;
    data['email'] = email;
    data['avtLink'] = avtLink;
    data['status'] = status;
    data['inLive'] = inLive ?? false;
    data['description'] = description;
    return data;
  }
}
