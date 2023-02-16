import 'package:demo_app/Services/firebase_services.dart';
import 'package:demo_app/Ui/Message/friends_screen.dart';
import 'package:demo_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum Gender { male, female, others }

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool fav = false;
  bool block = false;
  Gender gender = Gender.male;

  gen(Gender gender) {
    if (gender == Gender.male) {
      return "Male";
    } else if (gender == Gender.female) {
      return "Female";
    } else {
      return "others";
    }
  }

  // List gender = ["male", "female", "others"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(""),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              fav = !fav;
                            });
                            print(fav);
                          },
                          icon: fav == false
                              ? const Icon(
                                  Icons.star_border_sharp,
                                  color: Colors.amber,
                                )
                              : const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGwtznvDRImyLd_EzouJ4KFcfJxEg6vsannmmQB4hT&s"),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: nameController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  // border: InputBorder.none,
                  hintText: "Enter Name",
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  // border: InputBorder.none,
                  hintText: "Enter Email",
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Gender",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 17,
                      // fontWeight: FontWeight.w500
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Male"),
                      Radio(
                        value: Gender.male,
                        groupValue: gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            gender = value!;
                          });

                          print(value);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Female"),
                      Radio(
                        value: Gender.female,
                        groupValue: gender,
                        onChanged: (Gender? value) {
                          setState(
                            () {
                              gender = value!;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Others"),
                      Radio(
                        value: Gender.others,
                        groupValue: gender,
                        onChanged: (Gender? value) {
                          setState(
                            () {
                              gender = value!;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      if (nameController.text != "") {
                        final user = User(
                            id: DateTime.now().toIso8601String(),
                            name: nameController.text,
                            gender: gen(gender).toString(),
                            favorite: fav,
                            blocked: block);

                        await FirebaseService().createUser(user);
                        nameController.clear();
                        emailController.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendListScreen()),
                        );
                      }
                      await Fluttertoast.showToast(
                          msg: "Please enter your Name");
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.group_add_rounded),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Add"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        block = !block;
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.block_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Block"),
                      ],
                    ),
                  ),
                ],
              )
              // RadioMenuButton(value: "female", groupValue: "Female", onChanged: (v){}, child: child)
            ],
          ),
        ),
      ),
    );
  }
}
