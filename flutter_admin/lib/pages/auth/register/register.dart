import 'package:flutter/material.dart';
import 'package:flutter_admin/commands/register_cmd.dart';
import 'package:flutter_admin/exceptions/api_gql_exception.dart';
import 'package:flutter_admin/pages/auth/sign_in/sign_in.dart';
import 'package:flutter_admin/services/user_service.dart';
import 'package:flutter_admin/util/loader.dart';
import 'package:flutter_admin/util/snackbar.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/auth/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final UserService _service = UserService.instance;

  void _signIn() {
    Navigator.pushNamed(context, SignInPage.routeName);
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoader(context);
        RegisterCmd cmd =
            RegisterCmd(_name.text, _username.text, _password.text);
        await _service.register(cmd);
        hideLoader(context);

        flash(context, "Registration sucessful! Please login your account.");

        _formKey.currentState!.reset();
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
                    'Register a New Account',
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
                    controller: _name,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Name is required";

                      return null;
                    },
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
                          onPressed: _register,
                          child: const Text('Register Account'),
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
                          onPressed: _signIn,
                          child: const Text('Sign In Existing Account'),
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
