// import 'package:demo_app/Services/routes.dart' as route;
import 'package:demo_app/Services/api_repository.dart';
import 'package:demo_app/Ui/register_page.dart';
import 'package:demo_app/bloc/DictionaryBloc/dictionary_bloc_bloc.dart';
import 'package:demo_app/config/theme/theme.dart';
import 'package:demo_app/models/todo_model.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

// List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>("todoList");
  await Firestore.initialize(projectID);
  // await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

    return BlocProvider(
      create: (context) => DictionaryBlocBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: RegisterScreen(),
        // home:  User.id == ""  ? const MyHomePage() : LoginPage(),
      ),
    );
  }
}
