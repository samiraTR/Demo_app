import 'package:demo_app/Services/location.dart';
import 'package:demo_app/Ui/camera_screen.dart';
import 'package:demo_app/box/boxes.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Services/location.dart' as loc;
import 'package:demo_app/models/todo_model.dart';

class CreateScreen extends StatefulWidget {
  Function(List<ToDo>) todoFunc;
  List<ToDo> todoListfromCreate;
  CreateScreen({
    Key? key,
    required this.todoFunc,
    required this.todoListfromCreate,
  }) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  String address = "";
  int elementKey = 0;

  @override
  void initState() {
    if (widget.todoListfromCreate.isNotEmpty) {
      titleController.text = widget.todoListfromCreate.first.title;
      textController.text = widget.todoListfromCreate.first.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loc.Location().getLatLong();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    // widget.todoListfromCreate.clear();
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // var splitBySpace;
                    // splitBySpace = textController.text.split(" ");
                    // splitBySpace.reversed.toList();
                    // for (int i = 0; i < splitBySpace.length; i++) {
                    //   splitBySpace.removeAt(i);
                    //   i--;
                    //   break;
                    // }
                    // String d = splitBySpace.join(" ");
                    // print(d);
                  },
                  icon: const Icon(Icons.rotate_left),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.rotate_right),
                ),
                IconButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final box = Boxes.getData();
                      setState(() {
                        loc.Location().getLatLong();
                      });

                      // box.getAt(k);
                      // print(lat.toString());
                      final todoData = ToDo(
                          id: 0,
                          lat: lat.toString(),
                          long: long.toString(),
                          address: address,
                          title: titleController.text,
                          text: textController.text,
                          imgPath: '');

                      if (widget.todoListfromCreate.isNotEmpty) {
                        box.values.forEach((element) {
                          if (widget.todoListfromCreate.first.title ==
                              element.title) {
                            elementKey = element.key;
                          }
                        });
                        box.put(elementKey, todoData);
                      } else {
                        final todoData = ToDo(
                            id: 0,
                            lat: lat.toString(),
                            long: long.toString(),
                            address: address,
                            title: titleController.text,
                            text: textController.text,
                            imgPath: '');
                        box.add(todoData);
                      }
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                ),
                IconButton(
                  onPressed: () {
                    final box = Boxes.getData();
                    if (widget.todoListfromCreate.isNotEmpty) {
                      box.values.forEach((element) {
                        if (widget.todoListfromCreate.first.title ==
                            element.title) {
                          elementKey = element.key;
                        }
                      });
                      box.delete(elementKey);
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter Title"),
                style:
                    const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                onChanged: (value) {
                  titleController.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: titleController.selection);
                },
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: textController,
                      maxLines: 28,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Text"),
                      onChanged: (value) {
                        // var splitBySpace;
                        // splitBySpace = value.split(" ");

                        // for (int i = 0; i < splitBySpace.length; i++) {
                        //   splitBySpace.removeAt(i);
                        //   i--;
                        //   break;
                        // }
                        // splitBySpace.join();
                        // // var a = textDirectionToAxisDirection(TextDirection.rtl);

                        // (splitBySpace);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Stack(
              children: [
                Positioned(
                  left: 230,
                  top: 600,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      color: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CameraScreen()));
                          },
                          icon: const Icon(Icons.camera)),
                    ),
                  ),
                ),
                const Positioned(
                  right: 30,
                  bottom: 120,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      color: Colors.white,
                      child: Icon(Icons.image),
                    ),
                  ),
                ),
                // Positioned(left: 260, top: 580, child: Icon(Icons.cable)),
              ],
            );
          },
        );
      }),
    );
  }
}
