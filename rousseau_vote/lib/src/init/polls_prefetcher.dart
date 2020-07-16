
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/prefetch/prefetch_manager.dart';

// prefetches polls on startup GraphQLClient handles the cache
@singleton
class PollsPrefetcher with InitializeOnStartup {
  PollsPrefetcher();

  @override
  Future<QueryResult> doInitialize() async {
    return getIt<PrefetchManager>().prefetch(listPolls);
  }
}
