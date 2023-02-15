import 'package:demo_app/Ui/Message/friends_screen.dart';
import 'package:demo_app/Ui/todo_page.dart';
import 'package:demo_app/database_helper.dart';
import 'package:demo_app/models/grocery_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  // ignore: preferconstconstructorsinimmutables
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  String routeName = "MyHomePage";

  int? selectedId;
  // List<_SalesData> data = [
  //   _SalesData('Jan', 35),
  //   _SalesData('Feb', 28),
  //   _SalesData('Mar', 34),
  //   _SalesData('Apr', 32),
  //   _SalesData('May', 40)
  // ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter Your Text"),
          ),
          // title:  Text('Syncfusion Flutter chart'),
        ),
        endDrawer: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  DatabaseHelper.instance.downloadFolder();
                },
                child: const Text("Download"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    (MaterialPageRoute(
                      builder: (context) => const TodoScreen(),
                    )),
                  );
                },
                child: const Text("Create Task"),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    icon: const Icon(
                      Icons.message,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FriendListScreen(),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder<List<Grocery>>(
          future: DatabaseHelper.instance.getGroceries(),
          builder: (context, AsyncSnapshot<List<Grocery>> snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading");
            } else if (snapshot.data!.isEmpty) {
              return const Text("No Grocery List");
            }
            return ListView(
                children: snapshot.data!.map((e) {
              return ListTile(
                leading: Text(
                  e.name.toString(),
                ),
                onTap: () {
                  setState(() {
                    nameController.text = e.name.toString();
                    selectedId = e.id!;
                  });
                },
                onLongPress: () async {
                  // e.id == null
                  //     ? await DatabaseHelper.instance.removeNull(e.id!)
                  //     :
                  await DatabaseHelper.instance.remove(e.id!);
                  setState(() {
                    nameController.text = "";
                  });
                },
              );
            }).toList());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (nameController.text != "") {
              selectedId == null
                  ? await DatabaseHelper.instance
                      .add(Grocery(name: nameController.text))
                  : await DatabaseHelper.instance.update(
                      Grocery(name: nameController.text, id: selectedId));
            }
            setState(
              () {
                nameController.clear();
                selectedId = null;
              },
            );
          },
          child: const Icon(Icons.abc_outlined),
        ),
      ),
    );
  }
}

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }
