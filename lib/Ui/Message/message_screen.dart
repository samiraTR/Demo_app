import 'package:demo_app/Services/firebase_services.dart';
import 'package:demo_app/models/user_model.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messenger"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              // final docUser =
              //     FirebaseFirestore.instance.collection("person").doc();

              // // User.id = docUser.id;

              final user = User(
                  id: DateTime.now().toIso8601String(),
                  name: "Bristy",
                  gender: "Female",
                  favorite: true,
                  blocked: false);

              await FirebaseService().createUser(user);

              // await docUser.set(user.toJson());
            },
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
