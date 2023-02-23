import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Services/firebase_services.dart';
import 'package:flutter/material.dart';

import 'package:demo_app/models/messages_model.dart';

class MessageScreen extends StatefulWidget {
  String name;
  String id;
  MessageScreen({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toUpperCase()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: readMessages(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(" ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Align(
                                alignment:
                                    snapshot.data?[index].msgId == widget.id
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: snapshot.data?[index].msgId ==
                                              widget.id
                                          ? Colors.blue
                                          : Colors.amber,
                                      borderRadius: snapshot
                                                  .data?[index].msgId ==
                                              widget.id
                                          ? BorderRadius.circular(15).subtract(
                                              const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(12)))
                                          : BorderRadius.circular(15).subtract(
                                              const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(12)))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${snapshot.data?[index].message}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: IconButton(
                      onPressed: () async {
                        if (messageController.text != "") {
                          final msg = Message(
                              message: messageController.text,
                              createdAt: DateTime.now().toString(),
                              msgId: widget.id,
                              msgTo: "",
                              ksender: '');
                          messageController.clear();

                          await FirebaseService().sendMessage(msg, widget.id);
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Stream<List<Message>> readMessages(idUser) {
    return FirebaseFirestore.instance
        .collection("person/$idUser/messages")
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return Message.fromJson(doc.data());
      }).toList();
    });
  }
}
