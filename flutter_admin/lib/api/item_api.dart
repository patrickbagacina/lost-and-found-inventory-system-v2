import 'package:flutter_admin/api/api.dart';
import 'package:flutter_admin/api/gql_client.dart';
import 'package:flutter_admin/commands/create_item_cmd.dart';
import 'package:flutter_admin/commands/update_item_cmd.dart';
import 'package:flutter_admin/models/item.dart';
import 'package:flutter_admin/util/log.dart';
import 'package:graphql/client.dart';

class ItemApi extends API {
  final GQLClient _gql = GQLClient();

  Future<List<Item>> listItems() async {
    final client = await _gql.auth();
    final result = await client.query(
      QueryOptions(
        document: gql("""
              query {
                findAll {
                  item_id,
                  category,
                  item_type,
                  description,
                  brand,
                  is_claimed,
                  created_at,
                  updated_at
                }
              }
            """),
      ),
    );

    handle(result);

    List<Item> items = (result.data!['findAll'] as List<dynamic>)
        .map(
          (i) => Item.fromJson(i),
        )
        .toList();

    return items;
  }

  Future<Item> getItem(int id) async {
    final client = await _gql.auth();
    final result = await client.query(
      QueryOptions(
        document: gql("""
              query {
                findOne(item_id: $id) {
                  item_id,
                  category,
                  item_type,
                  description,
                  brand,
                  is_claimed,
                  created_at,
                  updated_at
                }
              }
            """),
      ),
    );

    handle(result);

    return Item.fromJson(result.data!['findOne']);
  }

  Future<void> createItem(CreateItemCmd cmd) async {
    final client = await _gql.auth();
    final result = await client.mutate(
      MutationOptions(
        document: gql("""
              mutation {
                registerItem(registerItemInput: {
                  category: "${cmd.category}",
                  item_type: "${cmd.itemType}",
                  brand: "${cmd.brand}",
                  description: "${cmd.description}"
                }) {
                  item_id,
                  category,
                  item_id,
                  description,
                  is_claimed,
                  created_at,
                  updated_at
                }
              }
            """),
      ),
    );

    handle(result);
  }

  Future<void> updateItem(UpdateItemCmd cmd) async {
    final client = await _gql.auth();
    final result = await client.mutate(
      MutationOptions(
        document: gql("""
              mutation {
                updateItem(updateItemInput: {
                  item_id: ${cmd.id},
                  category: "${cmd.category}",
                  item_type: "${cmd.itemType}",
                  brand: "${cmd.brand}",
                  description: "${cmd.description}",
                  is_claimed: ${cmd.isClaimed}
                }) {
                  item_id,
                  category,
                  item_id,
                  description,
                  is_claimed,
                  created_at,
                  updated_at
                }
              }
            """),
      ),
    );

    handle(result);
  }
}
