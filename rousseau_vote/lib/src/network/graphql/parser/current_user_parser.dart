
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class CurrentUserParser implements QueryResponseParser<CurrentUser> {
  @override
  CurrentUser parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data.get('currentUser');
    return CurrentUser.fromJson(lazyCacheMap.data);
  }
}