import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class PollListParser implements QueryResponseParser<PollList> {
  @override
  PollList parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return PollList.fromJson(lazyCacheMap.data);
  }
}