
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/responses/poll_answer_submit_response.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';

class PollAnswerSubmitResponseParser implements QueryResponseParser<PollAnswerSubmitResponse> {
  @override
  PollAnswerSubmitResponse parse(QueryResult result) {
    final LazyCacheMap lazyCacheMap = result.data['user'];
    return PollAnswerSubmitResponse.fromJson(lazyCacheMap.data);
  }
}

