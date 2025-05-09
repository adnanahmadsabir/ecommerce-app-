import 'package:clothes_app/domain/entities/item.dart';

typedef FutureMap = Future<Map<String, dynamic>?>;
typedef FutureList = Future<List<Item>?>;

abstract class ItemRepo {
  FutureMap add(String imagePath, Map<String, String> data);
  FutureList get();
}
