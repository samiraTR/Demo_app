// ignore_for_file: public_member_api_docs, sort_constructors_first

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  String message;
  String createdAt;
  String msgFrom;
  String msgTo;

  Message({
    required this.message,
    required this.createdAt,
    required this.msgFrom,
    required this.msgTo,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json["msg"],
      createdAt: json["createdAt"],
      msgFrom: json["msgFrom"],
      msgTo: json["msgTo"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "msgFrom": msgFrom,
      "msg": message,
      "createdAt": createdAt,
      "msgTo": msgTo
    };
  }
}
