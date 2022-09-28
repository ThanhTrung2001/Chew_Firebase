class ChatRoomModel{
  String? id;
  String? title;
  String? latestMessageContent;
  String? time;
  String? senderUID;
  List<String>? userInRoom;
  String? avtLink;
  ChatRoomModel(this.id, this.title, this.latestMessageContent, this.time, this.senderUID, this.userInRoom, this.avtLink);

  ChatRoomModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    latestMessageContent = json['latestMessageContent'];
    time = json['time'];
    senderUID = json['senderUID'];
    avtLink = json['avtLink'];
    userInRoom = json['userInRoom'];
    }
  
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['latestMessageContent'] = latestMessageContent;
    data['time'] = time;
    data['senderUID'] = senderUID;
    data['userInRoom'] = userInRoom;
    data['avtLink'] = avtLink;
    return data;
  }
}


