import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/models/user_model.dart';

class FirebaseService {
  Future createUser(User user) async {
    var docUser = FirebaseFirestore.instance.collection("person").doc();
    user.id = docUser.id;
    var json = user.toJson();
    await docUser.set(json);
  }
}
