import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.controller,
      this.prefixIcon, // optional
      this.suffixIcon, // optional
      this.isObscure = false, // optional
      this.contentPadding, // optional
      this.keyboardType = TextInputType.text, // optional
      this.borderRadius = 50, // optional
      this.inputFormatters = const []});

  final String hintText;
  final Widget? suffixIcon; // null check operation ?
  final String? Function(String?) validator;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final bool isObscure;
  final EdgeInsets? contentPadding;
  final TextInputType keyboardType;
  final double borderRadius;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: "$hintText...",
        hintStyle: TextStyle(fontSize: 14),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? EdgeInsets.zero,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide()),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide()),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide()),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide()),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide()),
      ),
      validator: validator,
    );
  }
}
