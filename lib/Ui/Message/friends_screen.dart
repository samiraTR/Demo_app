import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Ui/Message/message_screen.dart';
import 'package:demo_app/Ui/Message/profile_screen.dart';
import 'package:demo_app/models/user_model.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatefulWidget {
  final messages;
  const FriendListScreen({super.key, this.messages});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(" ${snapshot.error}");
          } else if (snapshot.hasData) {
            print(widget.messages);
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageScreen(
                                    name: snapshot.data![index].name,
                                    id: snapshot.data![index].id,
                                  )));
                    },
                    child: ListTile(
                      leading: Text(snapshot.data![index].name),
                      trailing: Container(
                        height: 45,
                        width: 38,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  final docUser = FirebaseFirestore.instance
                                      .collection("person")
                                      .doc(snapshot.data?[index].id.toString());
                                  docUser.delete();
                                });
                                print(snapshot.data![index].id.toString());
                              },
                              icon: const Icon(
                                Icons.group_remove,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<User>> readUsers() {
    return FirebaseFirestore.instance.collection("person").snapshots().map(
        (event) => event.docs.map((doc) => User.fromJson(doc.data())).toList());
  }
}
