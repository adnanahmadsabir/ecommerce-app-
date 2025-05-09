import 'package:flutter/material.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return isLoading
        ? Container(
            height: size.height,
            width: size.width,
            color: Theme.of(context).colorScheme.onInverseSurface,
            alignment: Alignment.center,
            child: const CircularProgressIndicator())
        : const SizedBox();
  }
}
