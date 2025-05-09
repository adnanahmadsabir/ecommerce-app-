import 'package:clothes_app/domain/entities/item.dart';
import 'package:clothes_app/ui/providers/item_provider.dart';
import 'package:clothes_app/ui/widgets/my_fonts.dart';
import 'package:clothes_app/ui/widgets/my_icon_button.dart';
import 'package:clothes_app/ui/widgets/my_network_image.dart';
import 'package:clothes_app/ui/widgets/my_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              MyNetworkImage(
                imagePath: item.imagePath!,
                height: MediaQuery.sizeOf(context).height * 0.54,
                width: MediaQuery.sizeOf(context).width,
              ),
            ],
          ),
          Column(
            children: [
              _topBar(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Theme.of(context).colorScheme.surfaceContainerLow),
                child: SingleChildScrollView(
                  child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 6,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            width: MediaQuery.sizeOf(context).width * 0.3),
                        SizedBox(
                          height: 12,
                        ),
                        MyFonts.headlineL(item.name ?? "Product"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 2,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(spacing: 6, children: [
                                  MyRatingBar(
                                      rating: double.parse(item.ratings!)),
                                  MyFonts.labelL(
                                    item.ratings ?? "0",
                                  )
                                ]),
                                MyFonts.bodyL(
                                  item.tags ?? 'N/A',
                                )
                              ],
                            ),
                            MyIconButton(
                              icon: Icons.add_circle_outline,
                              onPressed: () {
                                context.read<ItemProvider>().changeCount("+");
                              },
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(children: [
                              Expanded(
                                  child: MyFonts.titleL("Rs ${item.price}")),
                              Column(
                                children: [
                                  Selector<ItemProvider, int>(
                                    selector: (_, provider) =>
                                        provider.itemCount,
                                    builder: (_, itemCount, child) =>
                                        MyFonts.headlineS(itemCount.toString()),
                                  ),
                                  MyIconButton(
                                    onPressed: () => context
                                        .read<ItemProvider>()
                                        .changeCount("-"),
                                    icon: CupertinoIcons.minus_circle,
                                  )
                                ],
                              )
                            ]),
                          ],
                        ),
                        MyFonts.titleL("Size:"),
                        Row(
                          children: List<Widget>.generate(
                              4,
                              (index) =>
                                  _squareButton(_item['sizes']![index], index)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        MyFonts.titleL("Color:"),
                        Row(
                          children: List<Widget>.generate(
                              _item['colors']!.length,
                              (index) => _outlinedButton(
                                  _item['colors']![index], index)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        MyFonts.titleL("Description:"),
                        MyFonts.bodyL(item.description ?? 'No description'),
                        Align(
                          alignment: Alignment.center,
                          child: FilledButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                              label: Text('Add To Cart')),
                        )
                      ]),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget _rawButton({required bool isSelected, required String title}) =>
      Builder(builder: (context) {
        final primaryColor = Theme.of(context).colorScheme.primaryContainer;
        return Container(
            height: 26,
            margin: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * 0.17,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 2, color: primaryColor),
            ),
            child: MyFonts.titleM(title));
      });

  Widget _squareButton(String title, int index) {
    return Selector<ItemProvider, int>(
        selector: (_, provider) => provider.squareBtnIndex,
        builder: (context, squareBtnIndex, __) {
          return GestureDetector(
              onTap: () {
                context.read<ItemProvider>().changeIndex(index, true);
              },
              child: _rawButton(
                  isSelected: squareBtnIndex == index, title: title));
        });
  }

  static const _item = {
    'sizes': ["M", "L", "XL", "XXL"],
    'colors': ["blue", "black", 'red'],
  };

  Widget _outlinedButton(String title, int index) {
    return Selector<ItemProvider, int>(
        selector: (_, provider) => provider.roundBtnIndex,
        builder: (ctx, roundBtnIndex, __) {
          bool isSelected = roundBtnIndex == index;
          return GestureDetector(
              onTap: () {
                ctx.read<ItemProvider>().changeIndex(index, false);
              },
              child: _rawButton(isSelected: isSelected, title: title));
        });
  }

  Widget _topBar() => Builder(builder: (context) {
        Icon icon(IconData icon) =>
            Icon(icon, color: Theme.of(context).colorScheme.primary);
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.1,
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: icon(Icons.arrow_back)),
              Row(
                children: [
                  Selector<ItemProvider, String?>(
                      selector: (_, provider) => provider.isFavourite(),
                      builder: (ctx, isFavourite, __) => IconButton(
                          icon: icon(
                            isFavourite == '0'
                                ? Icons.bookmark_border
                                : Icons.bookmark_outline,
                          ),
                          onPressed: () {})),
                  IconButton(
                    icon: icon(Icons.shopping_cart_outlined),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        );
      });
}
