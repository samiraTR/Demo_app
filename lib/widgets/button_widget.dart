import 'package:flutter/material.dart';
import 'package:demo_app/utils/constant.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;
  const ButtonWidget({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: color),
      ),
    );
  }
}
