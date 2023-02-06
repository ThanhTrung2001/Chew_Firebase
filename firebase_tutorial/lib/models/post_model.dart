import 'package:firebase_tutorial/models/comment_model.dart';

class PostModel {
  // String? id;
  String? uid;
  String? avt;
  String? content;
  List<String>? imgLinks;
  List<String>? hearts;
  // List<CommentModel>? comments;
  DateTime? date;
  bool? isDelete;
  PostModel(

      // this.id,
      this.uid,
      this.avt,
      this.content,
      this.imgLinks,
      this.hearts,
      // this.comments,
      this.date,
      this.isDelete);

  PostModel.FromJson(Map<String, dynamic> json) {
    // id = json['id'];
    uid = json['uid'];
    avt = json['avt'];
    content = json['content'];
    imgLinks = json['imgLinks'];
    hearts = json['hearts'];
    // if (json['comments'] != null) {
    //   comments = <CommentModel>[];
    //   json['comments'].forEach((v) {
    //     comments!.add(new CommentModel.fromJson(v));
    //   });
    // }
    date = DateTime.parse(json['date']);
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['uid'] = this.uid;
    data['avt'] = this.avt;
    data['content'] = this.content;
    data['imgLinks'] = this.imgLinks;
    data['hearts'] = this.hearts;
    // if (this.comments != null) {
    //   data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    // }
    data['date'] = this.date;
    data['isDelete'] = this.isDelete;
    return data;
  }
}
