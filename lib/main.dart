import 'package:demo_app/database_helper.dart';
import 'package:demo_app/models/grocery_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  TextEditingController nameController = TextEditingController();
  int? selectedId;
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: nameController),
        // title:  Text('Syncfusion Flutter chart'),
      ),
      endDrawer: ElevatedButton(
          onPressed: () {
            DatabaseHelper.instance.downloadFolder();
          },
          child: Text("Download")),
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
                : await DatabaseHelper.instance
                    .update(Grocery(name: nameController.text, id: selectedId));
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
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
