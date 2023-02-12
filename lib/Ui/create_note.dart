// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:demo_app/Services/image.dart';
import 'package:demo_app/box/boxes.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:demo_app/Services/location.dart';
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
  CameraController? controller;
  bool iscameraInitialized = false;

  // String lat = "";
  // String long = "";
  // String address = "";
  // List<ToDo> todoList = [];
  double? lat;

  double? long;

  String address = "";
  String Updatedlat = "";
  var k;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    address = placemarks[0].street! + " " + placemarks[0].country!;

    if (mounted) {
      setState(() {});
    }
  }

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    widget.todoListfromCreate.clear();
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
                    getLatLong();

                    if (titleController.text.isNotEmpty) {
                      final box = boxes.getData();

                      // box.getAt(k);
                      final todoData = ToDo(
                          id: 0,
                          lat: lat.toString(),
                          long: long.toString(),
                          address: address,
                          title: titleController.text,
                          text: textController.text);

                      if (widget.todoListfromCreate.isNotEmpty) {
                        box.values.forEach((element) {
                          if (widget.todoListfromCreate.first.title ==
                              element.title) {
                            k = element.key;
                          }
                        });
                        box.put(k, todoData);
                      } else {
                        final todoData = ToDo(
                            id: 0,
                            lat: lat.toString(),
                            long: long.toString(),
                            address: address,
                            title: titleController.text,
                            text: textController.text);
                        box.add(todoData);
                      }
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                ),
                IconButton(
                  onPressed: () {
                    final box = boxes.getData();
                    if (widget.todoListfromCreate.isNotEmpty) {
                      box.values.forEach((element) {
                        if (widget.todoListfromCreate.first.title ==
                            element.title) {
                          k = element.key;
                        }
                      });
                      box.delete(k);
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
                // onChanged: (value) {
                //   if (widget.todoListfromCreate.isNotEmpty) {
                //     value = widget.todoListfromCreate.first.title;
                //   }
                // },
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
                              CameraFunctionality(context);
                            },
                            icon: Icon(Icons.camera)),
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
