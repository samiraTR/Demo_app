// import 'package:demo_app/Services/routes.dart' as route;
import 'package:demo_app/Ui/homepage.dart';
import 'package:demo_app/models/todo_model.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>("todoList");
  return runApp(const ChartApp());
}

class ChartApp extends StatelessWidget {
  const ChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}
