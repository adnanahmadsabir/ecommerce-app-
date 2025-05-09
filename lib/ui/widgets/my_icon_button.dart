import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key, required this.icon, this.onPressed, this.iconColor});

  final IconData icon;
  final Color? iconColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(),
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: Icon(
          icon,
          color: iconColor,
        ));
  }
}
