// ignore_for_file: use_build_context_synchronously, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_admin/commands/update_item_cmd.dart';
import 'package:flutter_admin/exceptions/api_gql_exception.dart';
import 'package:flutter_admin/models/item.dart';
import 'package:flutter_admin/pages/auth/list_items/list_items.dart';
import 'package:flutter_admin/services/item_service.dart';
import 'package:flutter_admin/util/loader.dart';
import 'package:flutter_admin/util/log.dart';
import 'package:flutter_admin/util/snackbar.dart';

class UpdateItemPage extends StatefulWidget {
  static const String routeName = '/items/update';

  const UpdateItemPage({super.key});

  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _brand = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ItemService _service = ItemService.instance;
  late Item? item = null;
  bool _isClaimed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      final id = arg as int;
      _getItem(id);
    }
  }

  void _getItem(int id) async {
    var i = await _service.getItem(id);

    setState(() {
      item = i;

      _isClaimed = item!.isClaimed;
      _category.text = item!.category;
      _type.text = item!.itemType;
      _brand.text = item!.brand;
      _description.text = item!.description;
    });
  }

  void _updateItem() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoader(context);
        UpdateItemCmd cmd = UpdateItemCmd(
          item!.itemId,
          _category.text,
          _type.text,
          _brand.text,
          _description.text,
          _isClaimed,
        );
        await _service.updateItem(cmd);
        hideLoader(context);

        flash(context, "Successfully updated item!");
      } on APIGraphQLException catch (err) {
        hideLoader(context);
        flash(context, err.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: item == null
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ListItemsPage.routeName);
                  },
                  child: const Text('Go Back to List Page'),
                ),
              ),
            )
          : Form(
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
                          'Update Item #${item!.itemId}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
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
                          readOnly: false,
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
                        ),
                        child: TextFormField(
                          controller: _description,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description is required";
                            }

                            return null;
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isClaimed = !_isClaimed;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Row(
                            children: <Widget>[
                              const Expanded(child: Text("Is Claimed?")),
                              Checkbox(
                                value: _isClaimed,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isClaimed = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
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
                                onPressed: _updateItem,
                                child: const Text('Save Changes'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ListItemsPage.routeName);
                                },
                                child: const Text('Back to list'),
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
