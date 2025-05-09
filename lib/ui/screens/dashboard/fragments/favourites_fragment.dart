import 'package:clothes_app/domain/entities/item.dart';
import 'package:flutter/material.dart';

class FavouritesFragment extends StatelessWidget {
  const FavouritesFragment({super.key});

  static Future<List<Item>> get future async => [];

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(12));
  }
}

// color: white,
// height: MediaQuery.sizeOf(context).height * 0.83,
// width: MediaQuery.sizeOf(context).height,
// child: Column(crossAxisAlignment: xAlignStart, children: [
//   MyFonts.displayL("Display", primary),
//   MyFonts.displayM("Display", primary),
//   MyFonts.displayS("Display", primary),
//   MyFonts.headlineL("Headline", primary),
//   MyFonts.headlineM("Headline", primary),
//   MyFonts.headlineS("Headline", primary),
//   MyFonts.titleL("Title", primary),
//   MyFonts.titleM("Title", primary),
//   MyFonts.titleS("Title", primary),
//   MyFonts.labelL("Label", primary),
//   MyFonts.labelM("Label", primary),
//   MyFonts.labelS("Label", primary),
//   MyFonts.bodyL("Body", primary),
//   MyFonts.bodyM("Body", primary),
//   MyFonts.bodyS("Body", primary)
// ]),
// ));
