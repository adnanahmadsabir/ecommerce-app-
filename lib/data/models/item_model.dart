import 'package:clothes_app/core/api.dart';
import 'package:clothes_app/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    super.id,
    super.name,
    super.price,
    super.ratings,
    super.tags,
    super.sizes,
    super.colors,
    super.description,
    super.imagePath,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        id: json['item_id'] ?? 0,
        name: json['name'] ?? "0",
        price: json['price'] ?? '0',
        ratings: json['ratings'] ?? '0',
        tags: json['tags'] ?? '0',
        sizes: json['sizes'] ?? '0',
        colors: json['colors'] ?? '0',
        description: json['description'] ?? '0',
        imagePath: "${Api.hostUrl}/clothes_app/admin/${json['imagePath']}");
  }

  Map<String, String> toJson() => {
        "name": name ?? "0",
        "price": price ?? "",
        "ratings": ratings ?? "",
        "tags": tags ?? "",
        "sizes": sizes ?? "",
        "colors": colors ?? "",
        "description": description ?? "",
        "imagePath": imagePath ?? ""
      };
}
