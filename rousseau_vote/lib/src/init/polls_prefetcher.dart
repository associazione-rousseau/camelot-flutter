
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';

// prefetches polls on startup GraphQLClient handles the cache
@singleton
class PollsPrefetcher with InitializeOnStartup {
  PollsPrefetcher();

  @override
  Future<QueryResult> doInitialize() async {
    final GraphQLClient client = getIt<GraphQLClient>();
    final QueryOptions options = QueryOptions(documentNode: gql(listPolls), fetchPolicy: FetchPolicy.networkOnly);
    final QueryResult queryResult = await client.query(options);
    return queryResult;
  }
}
