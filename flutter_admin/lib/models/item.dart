// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  int itemId;
  String category;
  String itemType;
  String description;
  String brand;
  bool isClaimed;
  String createdAt;
  String updatedAt;

  Item({
    required this.itemId,
    required this.category,
    required this.itemType,
    required this.description,
    required this.brand,
    required this.isClaimed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        category: json["category"],
        itemType: json["item_type"],
        description: json["description"],
        brand: json["brand"],
        isClaimed: json["is_claimed"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "category": category,
        "item_type": itemType,
        "description": description,
        "brand": brand,
        "is_claimed": isClaimed,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
