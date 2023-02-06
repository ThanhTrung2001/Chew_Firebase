class CommentModel {
  // String? id;
  String? uid;
  String? comment;
  String? imageLink;
  DateTime? date;
  CommentModel(

      // this.id,
      this.uid,
      this.comment,
      this.imageLink,
      this.date);
  CommentModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    uid = json['uid'];
    comment = json['comment'];
    imageLink = json['imageLink'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['uid'] = this.uid;
    data['comment'] = this.comment;
    data['imageLink'] = this.imageLink;
    data['date'] = this.date;
    return data;
  }
}
