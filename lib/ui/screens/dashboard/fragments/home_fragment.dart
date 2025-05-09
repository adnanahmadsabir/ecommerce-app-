import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_app/core/constants.dart';
import 'package:clothes_app/core/extensions.dart';
import 'package:clothes_app/core/label_keys.dart';
import 'package:clothes_app/core/my_future_builder.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/domain/entities/item.dart';
import 'package:clothes_app/ui/providers/item_provider.dart';
import 'package:clothes_app/ui/providers/search_bar_provider.dart';
import 'package:clothes_app/ui/screens/item_info_screen.dart';
import 'package:clothes_app/ui/screens/search_bar_screen.dart';
import 'package:clothes_app/ui/widgets/my_fonts.dart';
import 'package:clothes_app/ui/widgets/my_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  /// UI Portion
  @override
  Widget build(BuildContext context) {
    return Provider.of<SearchBarProvider>(context).isSearchActive
        ? SearchBarScreen()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MyFutureBuilder<List<Item?>>(
              future: context.read<ItemProvider>().getItems,
              onData: (items) => items.isEmpty
                  ? Utils.loader()
                  : Column(
                      spacing: 16,
                      crossAxisAlignment: xAlignStart,
                      children: [
                          GestureDetector(
                            onTap: () => context
                                .read<SearchBarProvider>()
                                .toggleSearchState(),
                            child: Container(
                              height: 50,
                              padding: xAxisPadding10,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                spacing: 8,
                                children: [
                                  Icon(
                                    Icons.search,
                                  ),
                                  MyFonts.titleM(searchProductsHereKey)
                                ],
                              ),
                            ),
                          ),
                          MyFonts.headlineS(trendingKey),
                          SizedBox(
                              height: 190,
                              child: _itemImagesWithTheirInfo(items)),
                          MyFonts.headlineS(newCollectionKey),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.45,
                            child: _itemTileWidget(items),
                          )
                        ]),
            ));
  }

  Widget _itemTileWidget(List<Item?> items) {
    return Builder(
        builder: (context) => ListView.builder(
            padding: padding4,
            physics: BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];

              return GestureDetector(
                onTap: () => Utils.getPage(context, ItemInfoScreen(item: item)),
                child: Container(
                  height: 120,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: _boxDecoration(context),
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: padding14,
                        child: Column(
                          spacing: 6,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Row(
                                  spacing: 6,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child:
                                          MyFonts.titleM(item!.name!.fixed()),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: MyFonts.titleM(
                                            "Rs ${item.price}",
                                          ),
                                        ))
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                    crossAxisAlignment: xAlignStart,
                                    children: [
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: MyFonts.bodyM("Tags"))),
                                      Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: MyFonts.bodyM(item.tags!
                                                .fixed(maxLength: 20))),
                                      ),
                                    ]))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                image: DecorationImage(
                                    onError: (_, stackTrace) => Icon(Icons.add),
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      "${item.imagePath}",
                                    )))))
                  ]),
                ),
              );
            }));
  }

  Widget _itemImagesWithTheirInfo(List<Item?> items) {
    return Builder(
        builder: (context) => ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: items.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => Utils.getPage(context, ItemInfoScreen(item: item)),
                child: Container(
                    width: 160,
                    height: 300,
                    margin: EdgeInsets.only(right: 10),
                    decoration: _boxDecoration(context),
                    child: Column(
                      spacing: 3,
                      children: [
                        MyNetworkImage(
                          height: 120,
                          width: 160,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          imagePath: item!.imagePath!,
                        ),
                        Padding(
                          padding: xAxisPadding4,
                          child: Row(
                            spacing: 2,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: xAlignStart,
                                  children: [
                                    MyFonts.bodyS(item.name!.fixed()),
                                    MyFonts.bodyS(item.tags!.fixed())
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: MyFonts.bodyS("Rs ${item.price ?? "0"}"),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: xAxisPadding6,
                            child: Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Row(children: [
                                    Utils.ratingIcon(Colors.yellow)
                                  ]),
                                ),
                                Expanded(
                                  child: MyFonts.labelS("(${item.ratings})"),
                                )
                              ],
                            ))
                      ],
                    )),
              );
            }));
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surfaceContainer);
  }
}
