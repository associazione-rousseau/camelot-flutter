
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class PollDetailParser implements QueryResponseParser<PollDetail> {
  @override
  PollDetail parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return PollDetail.fromJson(lazyCacheMap.data);
  }
}