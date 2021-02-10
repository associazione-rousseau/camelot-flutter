import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/fetcher/fetcher.dart';
import 'package:rousseau_vote/src/models/interface/has_pagination.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';

class GraphqlFetcher<T> implements Fetcher<T> {
  GraphqlFetcher({@required this.query, this.variables, this.pageSize = 20});

  final String query;
  final Map<String, dynamic> variables;
  final int pageSize;

  final GraphQLClient _graphQLClient = getIt<GraphQLClient>();

  @override
  Future<T> fetch() => _doFetch();

  @override
  Future<T> loadMore(T currentData) => _doFetch(after: _getAfter(currentData));

  @override
  Future<T> refresh() => _doFetch(fetchPolicy: FetchPolicy.networkOnly);

  String _getAfter(T currentData) =>
      currentData is HasPagination ? currentData.afterCursor() : null;

  Future<T> _doFetch(
      {String after, FetchPolicy fetchPolicy = FetchPolicy.cacheFirst}) async {
    final Map<String, dynamic> variables = _getVariables(after: after);
    final QueryOptions queryOptions = QueryOptions(
        documentNode: gql(query),
        variables: variables,
        fetchPolicy: fetchPolicy);
    final QueryResult result = await _graphQLClient.query(queryOptions);
    return getParser<T>().parse(result);
  }

  Map<String, dynamic> _getVariables({String after}) {
    final Map<String, dynamic> paginationVariables = after != null
        ? <String, dynamic>{'after': after, 'first': pageSize}
        : null;

    if (variables == null) {
      return paginationVariables;
    }

    if (paginationVariables != null) {
      variables.addAll(paginationVariables);
    }

    return variables;
  }
}
