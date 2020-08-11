

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/notification_badge_provider.dart';

void invalidatePollsList(Cache cache, QueryResult result) {
  invalidateQueryCache(cache, listPolls, result);
  final NotificationBadgeProvider provider = getIt<NotificationBadgeProvider>();
  provider.onPollsUpdate();
}

void invalidateCurrentUser(Cache cache, QueryResult result) {
  invalidateQueryCache(cache, currentUserShort, result);
  invalidateQueryCache(cache, currentUserFull, result);
  final NotificationBadgeProvider provider = getIt<NotificationBadgeProvider>();
  provider.onCurrentUserUpdated();
}

void invalidateQueryCache(Cache cache, String query, QueryResult result) {
  if (result == null || result.hasException || result.source != QueryResultSource.Network) {
    return;
  }
  final QueryOptions options = QueryOptions(documentNode: gql(query));
  final Operation operation = Operation.fromOptions(options)
    ..setContext(options.context);
  final String key = operation.toKey();
  cache.write(key, null);
}