import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(this.text,
      {super.key,
      this.color,
      this.fontWeight,
      this.fontStyle,
      this.fontSize,
      this.textAlign});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
