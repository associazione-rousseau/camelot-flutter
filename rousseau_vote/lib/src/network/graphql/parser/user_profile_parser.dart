
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class UserProfileParser implements QueryResponseParser<UserProfile> {
  @override
  UserProfile parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data.get('user');
    return UserProfile.fromJson(lazyCacheMap.data);
  }
}