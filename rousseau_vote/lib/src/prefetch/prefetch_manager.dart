
import 'dart:collection';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';

@singleton
class PrefetchManager {
  final HashSet<String> _prefetchedQueries = HashSet<String>();

  bool invalidateQuery(String query) {
    return _prefetchedQueries.remove(query);
  }

  bool hasPrefetchedData(String query) {
    return _prefetchedQueries.contains(query);
  }

  Future<QueryResult> prefetch(String query) async {
    final GraphQLClient client = getIt<GraphQLClient>();
    final QueryOptions options = QueryOptions(documentNode: gql(query), fetchPolicy: FetchPolicy.networkOnly);
    final QueryResult queryResult = await client.query(options);
    if (!queryResult.hasException) {
      _prefetchedQueries.add(query);
    }
    return queryResult;
  }
}