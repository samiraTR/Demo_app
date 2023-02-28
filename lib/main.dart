// import 'package:demo_app/Services/routes.dart' as route;
import 'package:demo_app/Ui/register_page.dart';
import 'package:demo_app/config/theme/theme.dart';
import 'package:demo_app/models/todo_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

// List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>("todoList");
  await Firebase.initializeApp();

  // try {
  //   cameras = await availableCameras();
  // } on CameraException catch (e) {
  //   print("Error in fetching the cameras $e");
  // }
  return runApp(const ChartApp());
}

class ChartApp extends StatelessWidget {
  const ChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const RegisterScreen(),
      // home:  User.id == ""  ? const MyHomePage() : LoginPage(),
    );
  }
}
