import 'package:clothes_app/core/validators.dart';
import 'package:clothes_app/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class MyPasswordTextField extends StatefulWidget {
  const MyPasswordTextField({super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  State<MyPasswordTextField> createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {

  bool _isObscure = true;

  void _toggleObscure() {
    setState(() => _isObscure = !_isObscure);
  }

  @override
  Widget build(BuildContext context) {
    return MyTextField(
        hintText: widget.hintText,
        isObscure: _isObscure,
        prefixIcon: const Icon(Icons.password),
        suffixIcon: GestureDetector(
          onTap: _toggleObscure,
          child: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
          ),
        ),
        validator: (text) => Validators.checkPassword(text),
        controller: widget.controller
    );
  }
}
