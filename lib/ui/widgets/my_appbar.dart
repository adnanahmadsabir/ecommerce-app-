import 'package:flutter/material.dart';

AppBar myAppbar(
    {required BuildContext context,
    required String title,
    bool isLeading = false,
    bool centerTitle = false,
    Color? color,
    List<Widget> actions = const [],
    Widget? leading,
    PreferredSizeWidget? bottom,
    double? toolBarHeight}) {
  return AppBar(
    bottom: bottom,
    toolbarHeight: toolBarHeight,
    title: Text(title),
    centerTitle: centerTitle ? true : false,
    automaticallyImplyLeading: isLeading,
    leading: leading,
    actions: actions,
  );
}
