import 'package:flutter_admin/api/auth_api.dart';
import 'package:flutter_admin/commands/register_cmd.dart';
import 'package:flutter_admin/commands/sign_in_cmd.dart';
import 'package:flutter_admin/models/user.dart';

class UserService {
  static final UserService instance = UserService._internal();

  factory UserService() {
    return instance;
  }

  UserService._internal();

  final AuthAPI _api = AuthAPI();

  Future<User> signIn(SignInCmd cmd) async {
    return _api.signIn(cmd);
  }

  Future<void> register(RegisterCmd cmd) async {
    return _api.register(cmd);
  }
}
