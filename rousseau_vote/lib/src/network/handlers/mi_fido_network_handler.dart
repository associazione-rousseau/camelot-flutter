import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/util/graphql_cache_util.dart';

@injectable
class MiFidoNetworkHandler {
  const MiFidoNetworkHandler(this._graphqlClient);

  final GraphQLClient _graphqlClient;

  Future<QueryResult> subscribe(UserProfile userProfile) async => _sendQuery(userProfile, true);

  Future<QueryResult> unsubscribe(UserProfile userProfile) => _sendQuery(userProfile, false);

  Future<QueryResult> _sendQuery(UserProfile userProfile, bool add) async {
    final String query = add ? subscriptionAdd : subscriptionDelete;
    return await _graphqlClient.mutate(MutationOptions(
        documentNode: gql(query),
        variables: <String, String>{'subscriptionableId': userProfile.id},
        update: (Cache cache, QueryResult result) {
          changeUserSubscription(cache, result, userProfile, add);
        }));
  }
}
