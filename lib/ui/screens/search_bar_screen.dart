import 'package:clothes_app/core/my_future_builder.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/ui/providers/search_bar_provider.dart';
import 'package:clothes_app/ui/widgets/my_loader.dart';
import 'package:clothes_app/ui/widgets/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SearchBarProvider>();
    return Stack(children: [
      SafeArea(
          child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Column(children: [
          MySearchBar(
              autoFocus: true,
              onBackBtnPressed: () => provider.toggleSearchState(),
              onChanged: (query) => provider.onQueryChanged(context, query!)),
          Expanded(
            child: MyFutureBuilder<List<String>?>(
                future: context.watch<SearchBarProvider>().searchItems,
                onNoData: Utils.emptyDataText(),
                onData: (names) {
                  return names == null || names.isEmpty
                      ? Utils.emptyDataText()
                      : ListView.builder(
                          itemCount: names.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                                onTap: () async => await provider.navigatePage(
                                    context, names[index]),
                                title: Text(names[index].toString()));
                          });
                }),
          )
        ]),
      )),
      Selector<SearchBarProvider, bool>(
          selector: (_, provider) => provider.isLoading,
          builder: (_, isLoading, __) => MyLoader(isLoading: isLoading))
    ]);
  }
}
