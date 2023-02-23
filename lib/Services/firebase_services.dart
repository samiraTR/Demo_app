import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/models/messages_model.dart';
import 'package:demo_app/models/user_model.dart';

const String myId = "V8Njbz9myUj0f7WSukev";

class FirebaseService {
  Future createUser(User user) async {
    var docUser = FirebaseFirestore.instance.collection("person").doc();
    user.id = docUser.id;
    var json = user.toJson();
    await docUser.set(json);
  }

  Future sendMessage(Message message, String idUser) async {
    var docUser =
        FirebaseFirestore.instance.collection("person/$idUser/messages").doc();
    message.msgId = docUser.id;
    var json = message.toJson();
    await docUser.set(json);
  }
}
