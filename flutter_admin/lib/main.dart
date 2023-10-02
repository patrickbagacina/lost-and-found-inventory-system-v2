import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/auth/sign_in/sign_in.dart';
import 'package:flutter_admin/pages/router.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  final AppRouter _route = AppRouter();

  @override
  State<App> createState() => _AppState(_route);
}

class _AppState extends State<App> {
  final AppRouter _router;

  _AppState(this._router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost and Found Inventory System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: _router.routes,
      initialRoute: SignInPage.routeName,
    );
  }
}
