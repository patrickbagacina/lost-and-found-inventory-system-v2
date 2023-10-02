// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin/commands/create_item_cmd.dart';
import 'package:flutter_admin/exceptions/api_gql_exception.dart';
import 'package:flutter_admin/pages/auth/list_items/list_items.dart';
import 'package:flutter_admin/services/item_service.dart';
import 'package:flutter_admin/util/loader.dart';
import 'package:flutter_admin/util/snackbar.dart';

class CreateItemPage extends StatefulWidget {
  static const String routeName = '/items/create';

  const CreateItemPage({super.key});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _brand = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ItemService _service = ItemService.instance;

  void _createItem() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoader(context);
        CreateItemCmd cmd = CreateItemCmd(
            _category.text, _type.text, _brand.text, _description.text);
        await _service.createItem(cmd);
        hideLoader(context);

        flash(context, "Successfully created a new item!");

        _formKey.currentState!.reset();

        Navigator.pushNamed(context, ListItemsPage.routeName);
      } on APIGraphQLException catch (err) {
        hideLoader(context);
        flash(context, err.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Text(
                    'Create a New Item',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: _category,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Category',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Category is required";

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: _type,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Item Type',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Item Type is required";

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: _brand,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Brand',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Brand is required";

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: _description,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Description is required";

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _createItem,
                          child: const Text('Save Item'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
