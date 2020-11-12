import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
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

  // TODO remove = 5
  Future<Poll> fetchPollDetails({ @required String pollId, int first = 5, String after, String fullName, List<String> badges}) async {
    badges ??= const <String>[]; // badges cannot be null. It has to be empty or non present
    final Map<String, dynamic> variables = {'pollId': pollId, 'first': first, 'after': after, 'fullName': fullName, 'badges': badges};
    final QueryOptions queryOptions = QueryOptions(documentNode: gql(pollDetail), variables: variables, fetchPolicy: FetchPolicy.networkOnly);
    final QueryResult result = await _graphQLClient.query(queryOptions);
    return getParser<PollDetail>().parse(result).poll;
  }
}
