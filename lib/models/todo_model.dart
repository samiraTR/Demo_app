import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String lat;
  @HiveField(2)
  String long;
  @HiveField(3)
  String address;
  @HiveField(4)
  String title;
  @HiveField(5)
  String text;

  ToDo({
    required this.id,
    required this.lat,
    required this.long,
    required this.address,
    required this.title,
    required this.text,
  });

  factory ToDo.fromMap(Map<String, dynamic> json) {
    return ToDo(
        id: json["id"],
        lat: json["lat"],
        long: json["long"],
        address: json["address"],
        title: json["title"],
        text: json["text"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "lat": lat,
      "long": long,
      "address": address,
      "title": title,
      "text": text
    };
  }
}
