import 'package:demo_app/models/todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class boxes {
  static Box<ToDo> getData() => Hive.box<ToDo>("todoList");
}
