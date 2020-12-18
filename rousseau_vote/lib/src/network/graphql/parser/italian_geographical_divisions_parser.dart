
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/geo/italian_geographical_divisions.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class ItalianGeographicalDivisionsParser implements QueryResponseParser<ItalianGeographicalDivisions> {
  @override
  ItalianGeographicalDivisions parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return ItalianGeographicalDivisions.fromJson(lazyCacheMap.data);
  }
}
