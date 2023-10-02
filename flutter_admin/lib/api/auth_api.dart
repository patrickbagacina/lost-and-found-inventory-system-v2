import 'package:flutter_admin/api/api.dart';
import 'package:flutter_admin/api/gql_client.dart';
import 'package:flutter_admin/commands/register_cmd.dart';
import 'package:flutter_admin/commands/sign_in_cmd.dart';
import 'package:flutter_admin/models/user.dart';
import 'package:graphql/client.dart';

class AuthAPI extends API {
  final GQLClient _gql = GQLClient();

  Future<User> signIn(SignInCmd cmd) async {
    final result = await _gql.anon().mutate(
          MutationOptions(
            document: gql("""
              mutation {
                login(loginUserInput: {
                  username: "${cmd.username}",
                  password: "${cmd.password}"
                }) {
                  user_id
                  username
                  name
                  access_token
                }
              }
            """),
          ),
        );

    handle(result);

    return User.fromJson(result.data!['login']);
  }

  Future<void> register(RegisterCmd cmd) async {
    final result = await _gql.anon().mutate(
          MutationOptions(
            document: gql("""
              mutation {
                registerUser(registerUserInput: {
                  name: "${cmd.name}",
                  username: "${cmd.username}",
                  password: "${cmd.password}"
                }) {
                  user_id
                  username
                  name
                }
              }
            """),
          ),
        );

    handle(result);
  }
}
