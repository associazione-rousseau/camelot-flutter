
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/prefetch/prefetch_manager.dart';

class StartupPrefetcher with InitializeOnStartup {
  StartupPrefetcher(this.queries);

  final List<String> queries;

  @override
  Future<List<QueryResult>> doInitialize() async {
    final List<QueryResult> results = <QueryResult>[];
    for(String query in queries) {
      final QueryResult queryResult = await getIt<PrefetchManager>().prefetch(query);
      results.add(queryResult);
    }
    return results;
  }
}