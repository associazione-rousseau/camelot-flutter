
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/ita_geo_division_list.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class ItaGeoDivisionListParser implements QueryResponseParser<ItaGeoDivisionList> {
  @override
  ItaGeoDivisionList parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return ItaGeoDivisionList.fromJson(lazyCacheMap.data);
  }
}