import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/store/token_store.dart';


class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: GRAPHQL_URL,
  );

  static AuthLink authLink = AuthLink(
    getToken: () async {
      final TokenStore tokenStore = getIt<TokenStore>();
      final String accessToken = await tokenStore.getAccessToken();
      return 'Bearer $accessToken';
    }
  );

  static Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: link,
    );
  }
}