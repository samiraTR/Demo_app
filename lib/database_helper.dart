import 'dart:async';
import 'dart:io';
import 'package:demo_app/models/grocery_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  var result;
  DatabaseHelper._prevConstructor();

  static final DatabaseHelper instance = DatabaseHelper._prevConstructor();

  ///////////////////////////////////initialize Database //////////////////////////

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<void> closefun() async {
    Database db = await instance.database;
    db.close;
  }

  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();

    // Directory dir = Directory("/storage/emulated/0/download/SQL_folder");
    // downloadFolder();
    String path = p.join(dir.path, "groceries.db");

    return await openDatabase(path, version: 3, onCreate: _onCreate);
  }

///////////////////////////////////Create Database Table //////////////////////////

  FutureOr<void> _onCreate(Database db, int version) async {
    String query =
        '''Create Table groceries(id INTEGER PRIMARY KEY, name TEXT)''';

    await db.execute(query);
  }

///////////////////////////////////get Database Table //////////////////////////

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((e) => Grocery.fromMap(e)).toList()
        : [];
    print("grocerylist from get grocery $groceryList");
    return groceryList;
  }
///////////////////////////////////insert Database Table //////////////////////////

  Future add(Grocery grocery) async {
    Database db = await instance.database;

    return await db.insert('groceries', grocery.toMap());
  }

///////////////////////////////////remove row  //////////////////////////

  Future<int> remove(int id) async {
    Database db = await instance.database;

    return await db.delete('groceries', where: "id = ?", whereArgs: [id]);
  }

///////////////////////////////////update row //////////////////////////
  Future<int> update(Grocery grocery) async {
    Database db = await instance.database;

    return await db.update('groceries', grocery.toMap(),
        where: "id = ?", whereArgs: [grocery.id]);
  }

///////////////////////////////////download table //////////////////////////
  Future<void> createFolder(Directory dir) async {
    dir.create();
    // if(Permission.storage.isGranted){

    // }
  }
///////////////////////////////////download table //////////////////////////

  Future<void> downloadFolder() async {
    Directory dir = Directory('/storage/emulated/0/Download/SQL_folder');

    if (await Permission.storage.status.isGranted) {
      if (await dir.exists()) {
        // dir.delete();
        dir.create();
      } else {
        dir.create();
      }
    } else {
      result = await Permission.storage.request();
      dir.create();
    }
    String path = p.join(dir.path, "groceries.db");

    await openDatabase(path, version: 3, onCreate: _onCreate);
    // if(Permission.storage.isGranted){

    // }
  }
}
