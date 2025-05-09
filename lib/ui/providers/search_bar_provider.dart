import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/domain/entities/item.dart';
import 'package:clothes_app/ui/providers/item_provider.dart';
import 'package:clothes_app/ui/screens/item_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchBarProvider extends ChangeNotifier {
  bool _isSearchActive = false;
  bool _isLoading = false;
  List<String> _searchItems = [];

  bool get isSearchActive => _isSearchActive;
  bool get isLoading => _isLoading;

  void toggleLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleSearchState() {
    _isSearchActive = !_isSearchActive;
    notifyListeners();
  }

  Future<List<String>?> get searchItems async => _searchItems;

  Future<void> navigatePage(BuildContext context, String name) async {
    toggleLoading(true);
    final item = await getItem(context, name);
    toggleLoading(false);
    if (!context.mounted) return;
    Utils.getPage(context, ItemInfoScreen(item: item));
  }

  void onQueryChanged(BuildContext context, String query) async {
    final items = await context.read<ItemProvider>().getItemsName;
    if (items.isEmpty) return;
    debugPrint("$_searchItems");
    _searchItems = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<Item> getItem(BuildContext context, String name) async {
    final items = await context.read<ItemProvider>().getItems;
    return items.firstWhere((item) => item.name == name);
  }
}
