import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/exceptions/session_expired_exception.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

// callback function called to render a widget in case of query error
typedef GraphqlErrorWidgetBuilder = Widget Function(List<GraphQLError> errors);

// callback function called to render a widget in case of query success
typedef GraphqlSuccessWidgetBuilder<T> = Widget Function(T data);

// callback function called to render a widget while a graphql query is loading
typedef GraphqlLoadingWidgetBuilder = Widget Function();

const FetchPolicy DEFAULT_CACHE_POLICY = FetchPolicy.cacheAndNetwork;

class GraphqlQueryWidget<T> extends StatefulWidget {
  const GraphqlQueryWidget(
      {@required this.query,
      @required this.builderSuccess,
      @required this.builderError,
      @required this.builderLoading,
      this.variables,
      this.pullToRefresh = false,
      this.fetchPolicy = DEFAULT_CACHE_POLICY,
      });

  final String query;
  final Map<String, dynamic> variables;
  final GraphqlSuccessWidgetBuilder<T> builderSuccess;
  final GraphqlErrorWidgetBuilder builderError;
  final GraphqlLoadingWidgetBuilder builderLoading;
  final FetchPolicy fetchPolicy;
  final bool pullToRefresh;

  @override
  _GraphqlQueryWidgetState<T> createState() => _GraphqlQueryWidgetState<T>();
}

class _GraphqlQueryWidgetState<T> extends State<GraphqlQueryWidget<T>> {

  QueryResult _queryResult;

  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(
      builder: (GraphQLClient client) {
        // Render results if already fetched
        if(_queryResult != null) {
          final QueryResponseParser<T> parser = getParser();
          final Widget successWidget = widget.builderSuccess(parser.parse(_queryResult));
          if (widget.pullToRefresh) {
            return RefreshIndicator(
              child: successWidget,
              onRefresh: _onPullToRefresh,
            );
          } else {
            return successWidget;
          }
        }

        // Else fetch
        _fetch();

        return widget.builderLoading();
      },
    );
  }

  Future<void> _onPullToRefresh() async {
    try {
      final QueryResult result = await _doFetch(fetchPolicy: FetchPolicy.networkOnly);
      if (result.hasException) {
        _onError(null);
        return;
      }
      _onResults(result);
    } catch (error) {
      _onError(error);
    }
  }

  void _fetch({FetchPolicy fetchPolicy}) {
    final Future<QueryResult> future = _doFetch(fetchPolicy: fetchPolicy);
    future.then((QueryResult result) => _onResults(result))
        .catchError((Object error) => _onError(error));
  }

  Future<QueryResult> _doFetch({FetchPolicy fetchPolicy}) {
    fetchPolicy ??= widget.fetchPolicy;
    final GraphQLClient client = getIt();
    final QueryOptions queryOptions = QueryOptions(documentNode: gql(widget.query), variables: widget.variables, fetchPolicy: fetchPolicy);
    return client.query(queryOptions);
  }
  
  void _onResults(QueryResult result) {
    if (_isSessionExpired(result)) {
      _onSessionExpired();
      return;
    }

    setState(() {
      _queryResult = result;
    });
  }

  bool _isSessionExpired(QueryResult result) {
    if (result.exception == null ||
        result.exception.clientException == null ||
        !(result.exception.clientException is UnhandledFailureWrapper)) {
      return false;
    }
    final UnhandledFailureWrapper failureWrapper = result.exception.clientException;

    return failureWrapper.failure is SessionExpiredException;
  }
  
  void _onError(Object error) {
    showSimpleSnackbar(context, textKey: 'error-network');
  }

  void _onSessionExpired() {
    Provider.of<Login>(context, listen: false).sessionExpired();
  }
}
