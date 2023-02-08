import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    String s = textController.text;
                    List<String> x = s.split(" ");
                    // var n;
                    // for (int i = x.length - 1; i >= 0;) {
                    //   print(x[i]);
                    //   x.removeAt(i);
                    //   i--;
                    //   print(x);
                    //   break;
                    // }

                    // for (int i = x.length; i > x.length; i++) {
                    //   x.removeLast();
                    //   // i--;
                    //   // print(x[i]);
                    //   // x.removeLast();
                    //   setState(() {});
                    //   break;
                    // }
                    // String result = x.substring(0, x.length - 1);

                    // print(result);
                    setState(() {});
                    // TextSelection.fromPosition();
                    // print(x);
                  },
                  icon: const Icon(Icons.rotate_left),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.rotate_right),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                ),
                IconButton(
                  onPressed: () {},
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter Your Text"),
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
                children: const [
                  Positioned(
                    left: 230,
                    top: 600,
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
                        child: Icon(Icons.camera),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 120,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        color: Colors.white,
                        child: Icon(Icons.image),
                      ),
                    ),
                  ),
                  // Positioned(left: 260, top: 580, child: Icon(Icons.cable)),
                ],
              );
            });
      }),
    );
  }
}
