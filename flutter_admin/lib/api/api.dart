import 'package:flutter_admin/exceptions/api_gql_exception.dart';
import 'package:graphql/client.dart';

import '../exceptions/api_unauthorized_exception.dart';
import '../util/log.dart';

abstract class API {
  void handle(QueryResult result) {
    log('Has error: ${result.hasException}');
    if (!result.hasException) return;

    String msg = result.exception!.graphqlErrors[0].message;
    switch (msg) {
      case "Unauthorized":
        throw APIUnauthorizedException();
      default:
        throw APIGraphQLException(msg);
    }
  }
}
