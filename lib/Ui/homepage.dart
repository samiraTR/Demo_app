import 'package:demo_app/Ui/Message/friends_screen.dart';
import 'package:demo_app/Ui/todo_page.dart';
import 'package:demo_app/bloc/counter_bloc.dart';
import 'package:demo_app/bloc/counter_event.dart';
import 'package:demo_app/database_helper.dart';
import 'package:demo_app/models/grocery_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  // static var routeName = "MyHomePage";

  // String routeName = "MyHomePage";

  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();

  int? selectedId;

  @override
  void initState() {
    // _bloc = CounterBloc();
    super.initState();
  }

  // Route route() {
  //   return MaterialPageRoute(
  //       settings: RouteSettings(name: widget.routeName),
  //       builder: (context) => MyHomePage());
  // }

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
              return InkWell(
                onTap: () {
                  setState(() {
                    nameController.text = e.name.toString();
                    selectedId = e.id!;
                  });
                },
                onLongPress: () async {
                  e.id == null
                      ? await DatabaseHelper.instance.remove(e.id!)
                      : await DatabaseHelper.instance.remove(e.id!);
                  setState(() {
                    nameController.text = "";
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                  child: buildRow(e),
                ),

                //  ListTile(
                //   leading: Text(
                //     e.name.toString(),
                //   ),
                //   trailing: Container(child: Text("1")),

                // ),
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

  Widget buildRow(Grocery e) {
    final _bloc = CounterBloc();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(e.name.toString()),
        StreamBuilder(
            stream: _bloc.outCounter,
            initialData: 0,
            builder: (context, AsyncSnapshot<int> snapshotnv) {
              var a;
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _bloc.counterEventSink.add(IncrementEvent());
                      },
                      icon: const Icon(Icons.add)),
                  Text(snapshotnv.data.toString()),
                  IconButton(
                      onPressed: () {
                        _bloc.counterEventSink.add(DeccrementEvent());
                      },
                      icon: const Icon(Icons.remove)),
                ],
              );
            })
      ],
    );
  }
}

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }
