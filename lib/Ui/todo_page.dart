import 'package:demo_app/Ui/create_note.dart';
import 'package:demo_app/box/boxes.dart';
import 'package:demo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<ToDo> todoList = [];
  List<ToDo> todoEditList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("data")),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<ToDo>>(
                valueListenable: Boxes.getData().listenable(),
                builder: (context, box, _) {
                  todoList = box.values.toList()..cast<ToDo>();

                  return GridView.builder(
                    itemCount: todoList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.9,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      todoList[index].title,
                                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa${todoList[index].address}");
                                        _openMap(todoList[index].lat, todoList[index].long, todoList[index].address);
                                      },
                                      icon: Image.asset(
                                        "assets/icons/map.png",
                                        height: 32,
                                        width: 32,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: Text(
                                  todoList[index].text,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                              // const Text(
                              //   "Lorem Ipsum is simply dummy text Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500 of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500",
                              //   style: TextStyle(
                              //       fontSize: 16, fontWeight: FontWeight.w400),
                              //   overflow: TextOverflow.ellipsis,
                              //   maxLines: 4,
                              // ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Card(
                                      elevation: 4,
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CreateScreen(todoFunc: (val) {}, todoListfromCreate: [todoList[index]]),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Card(
                                      elevation: 4,
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          _delete(todoList[index]);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          SizedBox(
            // height: 50,
            width: 80,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateScreen(
                                todoFunc: (List<ToDo> val) {
                                  setState(() {
                                    todoList = val;
                                  });
                                },
                                todoListfromCreate: const [],
                              )));
                },
                icon: const Icon(
                  Icons.add,
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<void> _openMap(String lat, String long, address) async {
    print(address);
    // String googleURL = "https://maps.google.com/?q=$lat,$long";
    String googleURL = "https://www.google.com/maps/search/?api=1&query=$address";

    // final String encodedURl = Uri.encodeFull(googleURL);

    await canLaunchUrlString(googleURL) ? await launchUrlString(googleURL) : throw ("error at $googleURL");
  }
}

void _delete(ToDo toDo) async {
  await toDo.delete();
}
