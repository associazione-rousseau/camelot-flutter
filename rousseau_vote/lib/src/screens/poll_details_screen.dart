import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/widgets/errors/error_page_widget.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/logged_screen.dart';
import 'package:rousseau_vote/src/widgets/vote/poll_details_body.dart';

class PollDetailsScreen extends StatelessWidget {
  const PollDetailsScreen(this.arguments);

  static const String ROUTE_NAME = '/poll_details';

  final PollDetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> variables = HashMap<String, dynamic>();
    variables.putIfAbsent('pollId', () => arguments.pollId);
    return LoggedScreen(Scaffold(
      body: GraphqlQueryWidget<PollDetail>(
        query: pollDetail,
        variables: variables,
        builderSuccess: (PollDetail pollDetail) => _page(context, pollDetail: pollDetail),
        builderError: (List<GraphQLError> errors) =>
            _page(context, errors: errors),
        builderLoading: () => _page(context, isLoading: true),
      ),
    ));
  }

  Widget _page(BuildContext context,
      {PollDetail pollDetail,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            backgroundColor: PRIMARY_RED,
            flexibleSpace: FlexibleSpaceBar(
                background: _header(context,
                    pollDetail: pollDetail,
                    isLoading: isLoading,
                    errors: errors)),
          ),
          _body(context,
              pollDetail: pollDetail, isLoading: isLoading, errors: errors),
        ],
      ),
    );
  }

  Widget _header(BuildContext context,
      {PollDetail pollDetail,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    if (isLoading || errors != null) {
      return Container();
    }
  }

  Widget _body(BuildContext context,
      {PollDetail pollDetail,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    if (isLoading) {
      return const SliverFillRemaining(child: LoadingIndicator());
    }
    if (errors != null) {
      return const SliverFillRemaining(child: ErrorPageWidget());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return PollDetailsBody(pollDetail.poll);
      }, childCount: 1),
    );
  }
}
