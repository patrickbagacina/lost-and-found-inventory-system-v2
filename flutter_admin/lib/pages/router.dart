import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/auth/create_item/create_item.dart';
import 'package:flutter_admin/pages/auth/list_items/list_items.dart';
import 'package:flutter_admin/pages/auth/register/register.dart';
import 'package:flutter_admin/pages/auth/sign_in/sign_in.dart';
import 'package:flutter_admin/pages/auth/update_item/update_item.dart';

class AppRouter {
  final Map<String, Widget Function(BuildContext)> _routes = {
    SignInPage.routeName: (ctx) => const SignInPage(),
    RegisterPage.routeName: (ctx) => const RegisterPage(),
    ListItemsPage.routeName: (ctx) => const ListItemsPage(),
    CreateItemPage.routeName: (ctx) => const CreateItemPage(),
    UpdateItemPage.routeName: (ctx) => const UpdateItemPage(),
  };

  Map<String, Widget Function(BuildContext)> get routes => _routes;
}
