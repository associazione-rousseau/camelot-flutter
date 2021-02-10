
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/user_subscriptions_list.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class UserSubscriptionsListParser implements QueryResponseParser<UserSubscriptionsList> {
  @override
  UserSubscriptionsList parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data['user'];
    return UserSubscriptionsList.fromJson(lazyCacheMap.data);
  }
}
