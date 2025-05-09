import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.color = Colors.black12,
      required this.onPressed,
      required this.text,
      this.borderRadius = 50});

  final Color color;
  final double borderRadius;
  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.tonal(
        onPressed: onPressed,
        child: Text(text.toString()),
        // ),
      ),
    );
  }
}
