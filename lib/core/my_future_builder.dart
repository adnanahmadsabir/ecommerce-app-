import 'package:clothes_app/core/utils.dart';
import 'package:flutter/material.dart';

class MyFutureBuilder<T> extends StatelessWidget {
  const MyFutureBuilder(
      {super.key,
      required this.future,
      required this.onData,
      this.loadingWidget,
      this.onError,
      this.onNoData});

  final Future<T> future;
  final Widget Function(T data) onData;
  final Widget? loadingWidget;
  final Widget Function(Object? error)? onError;
  final Widget? onNoData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<T>(
          future: future,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Utils.emptyDataText("Please wait, loading...");
            } else if (snapshot.hasError) {
              return Utils.errorText(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data == null) {
              return onNoData == null ? Utils.emptyDataText() : onNoData!;
            }
            return onData(snapshot.data as T);
          }),
    );
  }
}
