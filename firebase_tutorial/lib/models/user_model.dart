class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? avtLink;
  UserModel(this.uid, this.userName, this.email, this.avtLink);
  UserModel.fromJson(Map<String, dynamic> json){
  uid = json['uid'];
  userName = json['name'];
  email = json['email'];
  avtLink = json['avtLink'];
}

late UserModel currentUserLogedIn;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = userName;
    data['email'] = email;
    data['avtLink'] = avtLink;
    return data;
  }
}
