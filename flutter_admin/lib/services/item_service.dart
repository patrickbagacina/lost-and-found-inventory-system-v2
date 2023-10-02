import 'package:flutter_admin/api/auth_api.dart';
import 'package:flutter_admin/api/item_api.dart';
import 'package:flutter_admin/commands/create_item_cmd.dart';
import 'package:flutter_admin/commands/update_item_cmd.dart';
import 'package:flutter_admin/models/item.dart';

class ItemService {
  static final ItemService instance = ItemService._internal();

  factory ItemService() {
    return instance;
  }

  ItemService._internal();

  final ItemApi _api = ItemApi();

  Future<List<Item>> listItems() async {
    return _api.listItems();
  }

  Future<Item> getItem(int id) async {
    return _api.getItem(id);
  }

  Future<void> createItem(CreateItemCmd cmd) async {
    return _api.createItem(cmd);
  }

  Future<void> updateItem(UpdateItemCmd cmd) async {
    return _api.updateItem(cmd);
  }
}
