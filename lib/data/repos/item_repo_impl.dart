import 'package:clothes_app/data/models/item_model.dart';
import 'package:clothes_app/data/services/api_service.dart';
import 'package:clothes_app/domain/repos/item_repo.dart';
import 'package:flutter/cupertino.dart';

class ItemRepoImpl implements ItemRepo {
  final ApiService apiService;
  ItemRepoImpl(this.apiService);

  @override
  FutureMap add(String imagePath, Map<String, String> data) async {
    try {
      final result = await apiService.multiPartRequest(
          "admin/item_data.php", 'image', imagePath, data);
      return result;
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  @override
  FutureList get() async {
    try {
      final result =
          await apiService.get("admin/get_item.php") as Map<String, dynamic>;
      final items = (result['data'] as List<dynamic>)
          .map((json) => ItemModel.fromJson(json))
          .toList();
      return items;
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }
}
