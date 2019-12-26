import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/poll_details_body_content.dart';

class PollDetailsBody extends StatelessWidget {
  
  const PollDetailsBody(this.pollId);

  final String pollId;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> map = HashMap<String, dynamic>();
    map.putIfAbsent('pollId', () => pollId);
    return GraphqlQueryWidget<PollDetail>(
      query: pollDetail,
      variables: map,
      builderSuccess: (PollDetail data) {
        return PollDetailsBodyContent(data.poll);
      },
      builderLoading: () {
          return const LoadingIndicator();
        },
        builderError: (List<GraphQLError> error) {
          return Text(error.toString());
        },
    );
  }
}