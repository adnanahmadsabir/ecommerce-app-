import 'dart:convert';

import 'package:clothes_app/core/api.dart';
import 'package:clothes_app/domain/entities/item.dart';
import 'package:clothes_app/domain/usecases/item_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ItemProvider extends ChangeNotifier {
  final ItemUseCase itemUseCase;
  ItemProvider(this.itemUseCase);

  ItemUseCase get useCase => itemUseCase;
  double _rating = 0.0;

  /// Variables
  int _count = 0;
  int _squareBtnIndex = 0;
  int _roundBtnIndex = 0;
  bool _showButtons = false;
  List<Item?> _items = [];

  /// Getters
  double get rating => _rating;
  int get itemCount => _count;
  int get squareBtnIndex => _squareBtnIndex;
  int get roundBtnIndex => _roundBtnIndex;
  bool get showButtons => _showButtons;
  List<Item?> get items => _items;

  /// Events

  void setRating(double value) {
    _rating = value;
    notifyListeners();
  }

  void toggleButtonsState() {
    _showButtons = !_showButtons;
    notifyListeners();
  }

  void changeCount(String action) {
    if (action == "+") {
      _count == 12 ? _count : _count++;
    } else {
      _count == 0 ? _count : _count--;
    }
    notifyListeners();
  }

  void changeIndex(int index, bool isSquareBtn) {
    if (isSquareBtn) {
      _squareBtnIndex = index;
    } else {
      _roundBtnIndex = index;
    }
    notifyListeners();
  }

  /// HTTP EVENTS

  Future<List<String>> get getItemsName async => useCase.getItemsName();

  Future<List<Item>> get getItems async {
    final fetchedItems = await useCase.get() ?? [];
    _items = fetchedItems;
    notifyListeners();
    return fetchedItems;
  }

  final List<Item> _favouriteItems = [];
  // getter
  List<Item> get favouriteItems => List.unmodifiable(_favouriteItems);

  String? _isFavourite;
  String? isFavourite() => _isFavourite;
  void changeValue(String value) {
    _isFavourite = value == '0' ? '1' : '0';
    notifyListeners();
  }

  // fun for add item to toggle favourite items state
  Future<void> toggleFavouritesStatus(
    String isFav,
    String id,
  ) async {
    try {
      final req = await http.post(Uri.parse(Api.favouriteItems),
          body: {'isFavourite': isFav, 'item_id': id});
      debugPrint(isFav);
      if (req.statusCode == 200) {
        final jsonResp = await jsonDecode(req.body);
        // String msg = jsonResp['message'];

        if (jsonResp['success'] == 'true') {
          changeValue(isFav);
        }
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }
}
