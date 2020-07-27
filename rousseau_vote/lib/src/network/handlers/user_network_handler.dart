
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';
import 'package:rousseau_vote/src/network/response/user/feedback_submit_response.dart';
import 'package:rousseau_vote/src/network/response/user/user_response.dart';

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
    // _graphQLClient.mutate(options);
  }

  Future<FeedbackSubmitResponse> feedbackSubmit(String category, String feedback) async {
    final Map<String, String> feedbackVars = <String, String>{
			'category': category,
      'feedback': feedback
		};
    final MutationOptions mutationOptions = MutationOptions(
			documentNode: gql(userFeedbackSubmit),
			variables: feedbackVars
		);
    final QueryResult result = await _graphQLClient.mutate(mutationOptions);
    final LazyCacheMap lazyCacheMap = result.data.get('user');
    UserResponse userResponse =  UserResponse.fromJson(lazyCacheMap.data);
    if(userResponse != null && userResponse.userFeedbackSubmit != null){
      return userResponse.userFeedbackSubmit;
    }
    return null;
  }
}