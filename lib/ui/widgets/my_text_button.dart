import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, required this.onPressed, required this.title});

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Text(title,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )));
  }
}
