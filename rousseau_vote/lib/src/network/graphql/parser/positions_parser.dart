
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/profile/positions.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class PositionsParser implements QueryResponseParser<Positions> {
  @override
  Positions parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return Positions.fromJson(lazyCacheMap.data);
  }
}
