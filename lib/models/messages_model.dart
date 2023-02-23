// ignore_for_file: public_member_api_docs, sort_constructors_first

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  String message;
  String createdAt;
  String msgId;
  String msgTo;
  String ksender;

  Message({
    required this.message,
    required this.createdAt,
    required this.msgId,
    required this.msgTo,
    required this.ksender,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json["msg"],
        createdAt: json["createdAt"],
        msgId: json["msgFrom"],
        msgTo: json["msgTo"] ?? "",
        ksender: json["sender"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "msgFrom": msgId,
      "msg": message,
      "createdAt": createdAt,
      "msgTo": msgTo,
      "sender": ksender
    };
  }
}
