
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

import 'poll_list_parser.dart';

Map<Type, QueryResponseParser<dynamic>> map = <Type, QueryResponseParser<dynamic>>{
  PollList: PollListParser(),
};

QueryResponseParser<T> getParser<T>() {
  return map[T];
}

