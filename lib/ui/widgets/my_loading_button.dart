import 'dart:async';

import 'package:clothes_app/core/utils.dart';
import 'package:flutter/material.dart';

class MyLoadingButton<T> extends StatefulWidget {
  const MyLoadingButton(
      {super.key, required this.onPressed, required this.title});

  final Future<T> Function() onPressed;
  final String title;

  @override
  State<MyLoadingButton> createState() => _MyLoadingButtonState();
}

class _MyLoadingButtonState extends State<MyLoadingButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    if (mounted) {
    setState(() => _isLoading = true);
      await widget.onPressed().timeout(const Duration(seconds: 10),
          onTimeout: () {
        if (mounted) Utils.showSnackBar(context, 'Connection timed out.');
        setState(() => _isLoading = false);
      });
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: FilledButton.tonal(
            onPressed: _onPressed,
            child: _isLoading
                ? const SizedBox(
                    height: 22, width: 22, child: CircularProgressIndicator())
                : Text(widget.title)));
  }
}
