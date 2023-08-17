// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  Widget child;
  GradientWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 120, 47, 189),
          Color.fromARGB(255, 133, 76, 187),
          Color.fromARGB(255, 219, 110, 157),
          Color.fromARGB(255, 228, 133, 115),
          Color.fromARGB(255, 146, 212, 195),
        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
      ),
      child: child,
    );
  }
}
