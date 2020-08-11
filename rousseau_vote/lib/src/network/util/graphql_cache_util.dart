

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';

void invalidatePollsList(Cache cache) {
  invalidateQueryCache(cache, listPolls);
}

void invalidateQueryCache(Cache cache, String query) {
  final QueryOptions options = QueryOptions(documentNode: gql(query));
  final Operation operation = Operation.fromOptions(options)
    ..setContext(options.context);
  final String key = operation.toKey();
  cache.write(key, null);
}