
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class QueryResponseParser<T> {
  T parse(QueryResult result);
}