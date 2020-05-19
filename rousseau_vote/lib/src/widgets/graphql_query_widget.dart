import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/network/exceptions/session_expired_exception.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parsers.dart';
import 'package:rousseau_vote/src/providers/login.dart';

// callback function called to render a widget in case of query error
typedef GraphqlErrorWidgetBuilder = Widget Function(List<GraphQLError> errors);

// callback function called to render a widget in case of query success
typedef GraphqlSuccessWidgetBuilder<T> = Widget Function(T data);

// callback function called to render a widget while a graphql query is loading
typedef GraphqlLoadingWidgetBuilder = Widget Function();

class GraphqlQueryWidget<T> extends StatefulWidget {
  const GraphqlQueryWidget(
      {@required this.query,
      @required this.builderSuccess,
      @required this.builderError,
      @required this.builderLoading,
      this.variables});

  final String query;
  final Map<String, dynamic> variables;
  final GraphqlSuccessWidgetBuilder<T> builderSuccess;
  final GraphqlErrorWidgetBuilder builderError;
  final GraphqlLoadingWidgetBuilder builderLoading;

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
          return widget.builderSuccess(parser.parse(_queryResult));
        }

        // Else fetch
        final Future<QueryResult> future = client.query(QueryOptions(documentNode: gql(widget.query), variables: widget.variables));
        future.then((QueryResult result) => _onResults(result))
          .catchError((Object error) => _onError(error));

        return widget.builderLoading();
      },
    );
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
    // TODO Diversify the error
    _onSessionExpired();
  }

  void _onSessionExpired() {
    Provider.of<Login>(context).sessionExpired();
  }
}
