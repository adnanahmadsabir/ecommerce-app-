import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage(
      {super.key,
      this.height,
      this.width,
      required this.imagePath,
      this.borderRadius});

  final double? height, width;
  final String imagePath;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: Center(
            child: CachedNetworkImage(
          imageUrl: imagePath,
          height: height,
          width: width,
          alignment: Alignment.center,
          fit: BoxFit.cover,
          placeholder: (_, __) => Utils.emptyDataText("Loading..."),
          errorWidget: (_, __, ___) => const Icon(Icons.warning_amber),
        )),
      ),
    );
  }
}
