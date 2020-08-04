
import 'package:graphql_flutter/graphql_flutter.dart';

extension QueryResultUtil on QueryResult {
  bool get success => !hasException;
}