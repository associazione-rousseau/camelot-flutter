import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';

@singleton
class PollNetworkHandler {
  PollNetworkHandler(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<PollList> fetchPolls(
      {FetchPolicy fetchPolicy = FetchPolicy.networkOnly}) async {
    final QueryOptions queryOptions =
        QueryOptions(documentNode: gql(listPolls), fetchPolicy: fetchPolicy);
    final QueryResult result = await _graphQLClient.query(queryOptions);
    if (result.hasException) {
      throw result.exception;
    }
    return getParser<PollList>().parse(result);
  }
}
