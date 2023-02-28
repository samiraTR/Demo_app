import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // scaffoldBackgroundColor: Color.fromARGB(255, 5, 55, 96),
      fontFamily: 'Avenir',
      textTheme: textTheme());
}

TextTheme textTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
        color: Colors.black,
        fontFamily: 'Avenir',
        fontSize: 32,
        fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Avenir',
        fontSize: 24,
        fontWeight: FontWeight.bold),
    displaySmall: TextStyle(
        color: Colors.black,
        fontFamily: 'Avenir',
        fontSize: 18,
        fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
        color: Colors.black,
        fontFamily: 'Avenir',
        fontSize: 16,
        fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Avenir',
        fontSize: 14,
        fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        color: Colors.black,
        fontFamily: 'Avenir',
        fontSize: 14,
        fontWeight: FontWeight.normal),
  );
}
