
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';

@singleton
class UserNetworkHandler {

  UserNetworkHandler(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<CurrentUser> fetchCurrentUser() async {
    final QueryOptions queryOptions = QueryOptions(documentNode: gql(currentUserFull));
    final QueryResult result = await _graphQLClient.query(queryOptions);
    return getParser<CurrentUser>().parse(result);
  }

  Future<CurrentUser> updateCurrentUser(CurrentUser currentUser) async {
    // TODO implement mutation
//    _graphQLClient.mutate(options);
  }
}