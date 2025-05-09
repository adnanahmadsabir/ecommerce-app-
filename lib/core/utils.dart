import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text("$msg")));
  }

  static void errorToast(BuildContext context,
      [String msg = "Check your connection!"]) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)));
  }

  static void getPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static Widget loader() => const CircularProgressIndicator();

  static Widget errorText(String error) => Builder(builder: (context) {
        final isNetWorkError = error.contains("SocketException");
        final theme = Theme.of(context);
        return Text(
          isNetWorkError ? "No Internet Connection" : "Server Unavailable",
          style: theme.textTheme.headlineSmall
              ?.copyWith(color: theme.colorScheme.error),
        );
      });

  static Widget emptyDataText([String text = "No Data Found!"]) =>
      Builder(builder: (context) {
        final theme = Theme.of(context);
        return Center(
          child: Text(text,
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: theme.primaryColor)),
        );
      });

  static Widget bottomRightCornerRoundImage(
          BuildContext context, String imagePath) =>
      Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(imagePath))));

  static Icon ratingIcon([Color color = Colors.amber]) => Icon(
        Icons.star,
        color: color,
        size: 14,
      );
}
