class MessageModel{
  String? senderUID;
  bool? isImage;
  String? content;
  DateTime? time;
  MessageModel(this.senderUID, this.isImage, this.content, this.time);

  MessageModel.fromJson(Map<String, dynamic> json){
    senderUID = json['senderUID'];
    isImage = json['isImage'];
    content = json['content'];
    time = json['time'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderUID'] = senderUID;
    data['isImage'] = isImage;
    data['content'] = content;
    data['time'] = time;
    return data;
  }


}
