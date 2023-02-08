import 'package:flutter/material.dart';

class ToDo {
  int id;
  String lat;
  String long;
  String address;
  String title;
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
