import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/util/graphql_cache_util.dart';

@singleton
class VoteNetworkHandler {
  Future<QueryResult> submitVote(
      String pollId, List<Option> selectedOptions) async {
    final GraphQLClient client = getIt<GraphQLClient>();
    final List<String> selectedOptionsIds =
        selectedOptions.map((Option o) => o.id).toList();
    final Map<String, dynamic> variables = <String, dynamic>{
      'pollId': pollId,
      'optionIds': selectedOptionsIds
    };
    return await client.mutate(MutationOptions(
        documentNode: gql(pollAnswerSubmit),
        variables: variables,
        update: (Cache cache, QueryResult result) {
          if(!result.hasException) {
            invalidatePollsList(cache);
          }
        }));
  }
}
