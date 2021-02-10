
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class ProfileSearchParser implements QueryResponseParser<ProfileSearch> {
  @override
  ProfileSearch parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data;
    return ProfileSearch.fromJson(lazyCacheMap.data);
  }
}