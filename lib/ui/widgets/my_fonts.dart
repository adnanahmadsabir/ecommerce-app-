import 'package:flutter/material.dart';

class MyFonts {
// display types
  static Widget displayL(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.displayLarge));
  }

  static Widget displayM(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.displayMedium));
  }

  static Widget displayS(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.displayMedium));
  }

// headline types
  static Widget headlineL(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.headlineLarge));
  }

  static Widget headlineM(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.headlineMedium));
  }

  static Widget headlineS(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.headlineSmall));
  }

// titles
  static Widget titleL(String text) {
    return Builder(
        builder: (context) => Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ));
  }

  static Widget titleM(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.titleMedium));
  }

  static Widget titleS(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.titleSmall));
  }

  // body
  static Widget bodyL(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.bodyLarge));
  }

  static Widget bodyM(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.bodyMedium));
  }

  static Widget bodyS(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.bodySmall));
  }

  // labels
  static Widget labelL(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.labelLarge));
  }

  static Widget labelM(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.labelMedium));
  }

  static Widget labelS(String text) {
    return Builder(
        builder: (context) =>
            Text(text, style: Theme.of(context).textTheme.labelSmall));
  }
}
