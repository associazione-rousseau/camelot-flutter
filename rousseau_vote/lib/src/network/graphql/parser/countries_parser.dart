
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/geo/countries.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class CountriesParser implements QueryResponseParser<Countries> {
  @override
  Countries parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return Countries.fromJson(lazyCacheMap.data);
  }
}