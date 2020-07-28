
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/country_list.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class CountryListParser implements QueryResponseParser<CountryList> {
  @override
  CountryList parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return CountryList.fromJson(lazyCacheMap.data);
  }
}