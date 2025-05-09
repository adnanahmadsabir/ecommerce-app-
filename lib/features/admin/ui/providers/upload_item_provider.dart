import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/data/models/item_model.dart';
import 'package:clothes_app/domain/usecases/item_use_case.dart';
import 'package:clothes_app/features/admin/ui/screens/admin_home_screen.dart';
import 'package:flutter/material.dart';

class UploadItemProvider extends ChangeNotifier {
  final ItemUseCase itemUseCase;
  UploadItemProvider(this.itemUseCase);
  ItemUseCase get useCase => itemUseCase;

  /// VARIABLES
  bool _isUploading = false;
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final ratingsCtrl = TextEditingController();
  final sizesCtrl = TextEditingController();
  final tagsCtrl = TextEditingController();
  final colorsCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  /// GETTERS
  bool get isUploading => _isUploading;

  /// EVENTS
  void toggleUploadState(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  void clearAllFields() {
    nameCtrl.clear();
    priceCtrl.clear();
    ratingsCtrl.clear();
    sizesCtrl.clear();
    tagsCtrl.clear();
    colorsCtrl.clear();
    descCtrl.clear();
  }

  /// HTTP EVENTS
  Future<void> uploadItemData(BuildContext context,
      {required String? imagePath}) async {
    toggleUploadState(true);
    final item = ItemModel(
      name: nameCtrl.text,
      price: priceCtrl.text,
      ratings: ratingsCtrl.text,
      sizes: sizesCtrl.text,
      tags: tagsCtrl.text,
      colors: colorsCtrl.text,
      description: descCtrl.text,
    ).toJson();
    // mysql stores boolean data as 1 and 0 instead of  true and false
    final isAdded = await useCase.add(imagePath!, item);
    if (!context.mounted) return;
    switch (isAdded) {
      case null:
        break;
      case false:
        Utils.showSnackBar(context, "Fail, try again later!");
        break;
      default:
        clearAllFields();
        Utils.getPage(context, AdminHomeScreen());
    }
    toggleUploadState(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameCtrl.dispose();
    priceCtrl.dispose();
    ratingsCtrl.dispose();
    sizesCtrl.dispose();
    tagsCtrl.dispose();
    colorsCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }
}
