import 'dart:io';

import 'package:flutter_admin/services/storage_service.dart';
import 'package:graphql/client.dart';

class GQLClient {
  Future<GraphQLClient> auth() async {
    // ignore: todo
    // TODO: Add URL to config file
    var httpLink = HttpLink("http://localhost:3000/graphql");
    String token = await StorageService.instance.getAccessToken();
    var authLink = AuthLink(getToken: () => "Bearer $token");
    var link = authLink.concat(httpLink);

    return GraphQLClient(link: link, cache: GraphQLCache());
  }

  GraphQLClient anon() {
    var httpLink = HttpLink("http://localhost:3000/graphql");
    return GraphQLClient(link: httpLink, cache: GraphQLCache());
  }
}
