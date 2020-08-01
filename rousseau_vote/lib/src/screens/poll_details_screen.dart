import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/errors/error_page_widget.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/logged_screen.dart';
import 'package:rousseau_vote/src/widgets/rousseau_animated_screen.dart';
import 'package:rousseau_vote/src/widgets/vote/poll_details_body.dart';

class PollDetailsScreen extends StatelessWidget {
  const PollDetailsScreen(this.arguments);

  static const String ROUTE_NAME = '/poll_details';

  final PollDetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> variables = HashMap<String, dynamic>();
    variables.putIfAbsent('pollId', () => arguments.pollId);
    return ChangeNotifierProvider<VoteOptionsProvider>(
      builder: (BuildContext context) => VoteOptionsProvider(),
      child: Consumer<VoteOptionsProvider>(
          builder: (BuildContext context, value, child) => LoggedScreen(GraphqlQueryWidget<PollDetail>(
                    query: pollDetail,
                    variables: variables,
                    builderSuccess: (PollDetail pollDetail) =>
                        _page(context, pollDetail: pollDetail),
                    builderError: (List<GraphQLError> errors) =>
                        _page(context, errors: errors),
                    builderLoading: () => _page(context, isLoading: true),
                  ),
                ),
              ),
    );
  }

  Widget _page(BuildContext context,
      {PollDetail pollDetail,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    if (pollDetail != null) {
      Provider.of<VoteOptionsProvider>(context).onPollFetched(pollDetail.poll);
    }
    return RousseauAnimatedScreen(
      extendedAppBar: _header(context,
          pollDetail: pollDetail, isLoading: isLoading, errors: errors),
      appBar: const Image(
        image: WHITE_LOGO,
        height: 50,
      ),
      floatingActionButton: _floatingActionButton(context),
      body: _body(context,
          pollDetail: pollDetail, isLoading: isLoading, errors: errors),
      backgroundColor: BACKGROUND_GREY,
    );
  }

  Widget _header(BuildContext context,
      {PollDetail pollDetail,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    if (isLoading || errors != null || pollDetail == null) {
      return Container(
        height: 200,
      );
    }
    final Poll poll = pollDetail.poll;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        children: <Widget>[
          const VerticalSpace(60),
          Text(
            poll.title,
            maxLines: 3,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
              child: Divider(
                thickness: 2,
                color: Colors.white,
              )),
          Text(
            poll.description,
            maxLines: 10,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const VerticalSpace(40),
//        Padding(padding: const EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10), child: Divider(thickness: 2, color: Colors.white,)),
//        Text(
//          RousseauLocalizations.getTextPlualized(context, 'vote-preferences-v2-s', 'vote-preferences-v2-p', poll.maxSelectableOptionsNumber),
//          style: TextStyle(
//              color: Colors.white,
//              fontWeight: FontWeight.w300,
//              fontSize: 15),
//          textAlign: TextAlign.center,
//        )
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return Provider.of<VoteOptionsProvider>(context).hasSelectedOptions()
        ? Container(
            width: 110,
            height: 110,
            child: FittedBox(
                child: FloatingActionButton.extended(
              label:
                  Text(RousseauLocalizations.getText(context, 'vote-button')),
              icon: Icon(Icons.send),
              onPressed: () => _onSend(context),
            )))
        : null;
  }

  void _onSend(BuildContext context) {}

  Widget _body(BuildContext context,
      {PollDetail pollDetail,
      bool isLoading = false,
      List<GraphQLError> errors}) {
    if (isLoading) {
      return const LoadingIndicator();
    }
    if (errors != null) {
      return const ErrorPageWidget();
    }

    return PollDetailsBody(pollDetail.poll);
  }
}
