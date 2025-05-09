import 'package:clothes_app/domain/entities/item.dart';
import 'package:clothes_app/domain/repos/item_repo.dart';

class ItemUseCase {
  final ItemRepo itemRepo;
  ItemUseCase(this.itemRepo);
  ItemRepo get _repo => itemRepo;

  Future<bool?> add(String imagePath, Map<String, String> data) async {
    final result = await _repo.add(imagePath, data);
    if (result == null) return null;
    return result['success'] == false ? false : true;
  }

  Future<List<Item>?> get() async => await _repo.get();

  Future<List<String>> getItemsName() async {
    final items = await get();
    final names = <String>[];
    if (items != null) {
      for (var item in items) {
        names.add(item.name!);
      }
    }
    return names;
  }
}
