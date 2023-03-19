class ChatRoom {
  String? sId;
  String? user1;
  String? user2;
  List<Messages>? messages;

  ChatRoom({this.sId, this.user1, this.user2, this.messages});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user1 = json['user1'];
    user2 = json['user2'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user1'] = this.user1;
    data['user2'] = this.user2;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? text;
  String? sender;

  Messages({this.text, this.sender});

  Messages.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    sender = json['sender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['sender'] = this.sender;
    return data;
  }
}
