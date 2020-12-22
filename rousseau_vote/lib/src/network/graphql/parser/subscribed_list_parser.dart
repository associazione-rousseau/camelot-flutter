
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/subscribed_list.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class SubscribedListParser implements QueryResponseParser<SubscribedList> {
  @override
  SubscribedList parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data['user'];
    return SubscribedList.fromJson(lazyCacheMap.data);
  }
}
