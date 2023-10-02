// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin/commands/sign_in_cmd.dart';
import 'package:flutter_admin/exceptions/api_gql_exception.dart';
import 'package:flutter_admin/exceptions/api_unauthorized_exception.dart';
import 'package:flutter_admin/models/user.dart';
import 'package:flutter_admin/pages/auth/list_items/list_items.dart';
import 'package:flutter_admin/pages/auth/register/register.dart';
import 'package:flutter_admin/services/storage_service.dart';
import 'package:flutter_admin/services/user_service.dart';
import 'package:flutter_admin/util/loader.dart';
import 'package:flutter_admin/util/snackbar.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/auth/sign-in';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final UserService _service = UserService.instance;
  final StorageService _storage = StorageService.instance;

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoader(context);
        SignInCmd cmd = SignInCmd(_username.text, _password.text);
        User user = await _service.signIn(cmd);
        _storage.setUser(user);
        hideLoader(context);

        flash(context, "Login sucessful!");

        Navigator.pushNamed(
          context,
          ListItemsPage.routeName,
        );
      } on APIUnauthorizedException {
        hideLoader(context);
        flash(context, "Invalid credentials");
      } on APIGraphQLException catch (err) {
        hideLoader(context);
        flash(context, err.message);
      }
    }
  }

  void _register() {
    Navigator.pushNamed(context, RegisterPage.routeName);
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
                    'Sign In Your Account',
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
                    controller: _username,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Username is required";

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
                    controller: _password,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Password is required";

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
                          onPressed: _signIn,
                          child: const Text('SIGN IN'),
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
                          onPressed: _register,
                          child: const Text('REGISTER'),
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
