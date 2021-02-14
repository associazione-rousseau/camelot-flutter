import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/models/poll_detail_arguments.dart';
import 'package:rousseau_vote/src/models/responses/poll_answer_submit_response.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/network/handlers/vote_network_handler.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/util/graphql_util.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/core/icon_text_screen.dart';
import 'package:rousseau_vote/src/widgets/dialog/confirm_vote_dialog.dart';
import 'package:rousseau_vote/src/widgets/dialog/dismissable_dialog.dart';
import 'package:rousseau_vote/src/widgets/dialog/loading_dialog.dart';
import 'package:rousseau_vote/src/widgets/errors/error_page_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/logged_screen.dart';
import 'package:rousseau_vote/src/widgets/profile/badge_image.dart';
import 'package:rousseau_vote/src/widgets/rousseau_animated_screen.dart';
import 'package:rousseau_vote/src/widgets/vote/poll_details_body.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PollDetailsScreen extends StatelessWidget {
  const PollDetailsScreen(this.arguments);

  static const String ROUTE_NAME = '/poll_details';

  final PollDetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VoteOptionsProvider>(
      create: (BuildContext context) => VoteOptionsProvider(pollId: arguments.pollId),
      child: Consumer<VoteOptionsProvider>(
        builder: (BuildContext context, VoteOptionsProvider provider, Widget child) => LoggedScreen(
          _page(context),
        ),
      ),
    );
  }

  Widget _page(BuildContext context) {
    final VoteOptionsProvider provider = Provider.of(context);
    return RousseauAnimatedScreen(
      extendedAppBar: _header(context,
          poll: provider.poll, isLoading: provider.isLoading, error: provider.error),
      appBar: const Image(
        image: WHITE_LOGO,
        height: 50,
      ),
      floatingActionButton: _floatingActionButton(context),
      body: _body(context,
          poll: provider.poll, isLoading: provider.isLoading, error: provider.error),
    );
  }

  Widget _header(BuildContext context,
      {Poll poll,
      bool isLoading = false,
      dynamic error}) {
    if (poll == null) {
      return Container(
        height: 200,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        children: <Widget>[
          const VerticalSpace(60),
          Text(
            poll.title,
            maxLines: 3,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const Padding(
              padding:
                  EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
              child: Divider(
                thickness: 2,
                color: Colors.white,
              )),
          Text(
            poll.description,
            style: const TextStyle(
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
    return Provider.of<VoteOptionsProvider>(context, listen: false)
            .hasSelectedOptions()
        ? Container(
            width: 150,
            height: 150,
            child: FittedBox(
                child: FloatingActionButton.extended(
              label:
                  Text(RousseauLocalizations.getText(context, 'vote-button')),
              icon: const Icon(Icons.send),
              onPressed: () => _onSend(context),
            )))
        : null;
  }

  void _onSend(BuildContext context) {
    final VoteOptionsProvider provider =
        Provider.of<VoteOptionsProvider>(context, listen: false);
    _showDialog(
        context,
        ConfirmVoteDialog(
            selectedOptions: provider.getSelectedOptions(),
            remainingOptions: provider.remainingOptions(),
            pollType: provider.getPollType(),
            onConfirm: () {
              Navigator.of(context).pop();
              _onVoteConfirm(context);
            }));
  }

  void _onVoteConfirm(BuildContext context) {
    final VoteNetworkHandler voteNetworkHandler = getIt<VoteNetworkHandler>();
    final VoteOptionsProvider provider =
        Provider.of<VoteOptionsProvider>(context, listen: false);
    _onVoteConfirmLoading(context);
    voteNetworkHandler
        .submitVote(arguments.pollId, provider.getSelectedOptions())
        .then((PollAnswerSubmitResponse response) {
      if (response.success) {
        _onVoteConfirmSuccess(context);
      } else {
        final String errorMessage = response.alreadyVoted ?
          RousseauLocalizations.getText(context, 'vote-already')
            : response.errorMessage;
        _onVoteConfirmError(context, errorMessage);
      }
    }).catchError((dynamic object) {
      final String errorMessage = RousseauLocalizations.getText(context, 'error-network');
      _onVoteConfirmError(context, errorMessage);
    });
  }

  void _onVoteConfirmLoading(BuildContext context) {
    _showDialog(
        context,
        const LoadingDialog(
          titleKey: 'vote-confirm-sending',
        ));
  }

  void _onVoteConfirmSuccess(BuildContext context) {
    Navigator.of(context).pop();
    final Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const VerticalSpace(30),
        const Icon(
          Icons.done_all,
          color: Colors.green,
        ),
        Text(
          RousseauLocalizations.getText(context, 'vote-already-done'),
          textAlign: TextAlign.center,
        )
      ],
    );
    final List<FlatButton> buttons = <FlatButton>[
      FlatButton(
        child: Text(
          RousseauLocalizations.getText(context, 'back-polls'),
        ),
        onPressed:
            openRouteAction(context, PollsScreen.ROUTE_NAME, replace: true),
      )
    ];
    final Widget dialog = AlertDialog(
      content: SingleChildScrollView(
        child: body,
      ),
      actions: buttons,
    );
    _showDialog(context, dialog);
  }

  void _onVoteConfirmError(BuildContext context, String errorMessage) {
    Navigator.of(context).pop();
    final Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const VerticalSpace(30),
        const Icon(Icons.cloud_off),
        Text(errorMessage, textAlign: TextAlign.center,)
      ],
    );
    _showDialog(context, DismissableDialog(body: body));
  }

  void _showDialog(BuildContext context, Widget dialog) {
    showDialog<void>(
        context: context,
        barrierColor: Colors.grey,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => dialog);
  }

  Widget _body(BuildContext context,
      {Poll poll,
      bool isLoading = false,
      dynamic error}) {
    if (error != null) {
      return const ErrorPageWidget();
    }
    if (poll != null && poll.closed) {
      final IconData iconData =
          poll.alreadyVoted ? Icons.event_available : Icons.event_busy;
      final String messageKey = poll.alreadyVoted
          ? 'poll-closed-already-voted'
          : 'poll-closed-did-not-vote';
      return IconTextScreen(
        iconData: iconData,
        messageKey: messageKey,
      );
    }

    if (poll != null && poll.alreadyVoted) {
      return const IconTextScreen(
        iconData: Icons.event_available,
        messageKey: 'poll-voted',
        textColor: Colors.green,
        iconColor: Colors.green,
      );
    }

    if (poll != null && poll.open && !poll.hasRequirements) {
      return const IconTextScreen(
        iconData: Icons.error_outline,
        messageKey: 'poll-alert',
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
            ConditionalWidget(
            condition: poll != null && poll.isCandidatePoll,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 45, left: 5, right: 5),
              child: Column(
                children: <Widget>[_searchBar(context), const VerticalSpace(30), _meritsFilter(context)],
              ),
            ),
          ),
          ConditionalWidget(condition: isLoading, child: const LoadingIndicator()),
          ConditionalWidget(condition: !isLoading, child: PollDetailsBody(poll)),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ConditionalWidget(condition: !isLoading && poll != null && poll.hasNextPage, child: _loadMoreIndicator(context)),
          ),
        ],
      ),
    );
  }

  Widget _loadMoreIndicator(BuildContext context) {
    return VisibilityDetector(
      key: const Key('poll-loading-indicator'),
      onVisibilityChanged: (VisibilityInfo visibilityInfo) {
        if(visibilityInfo.visibleFraction == 1) {
          _loadMore(context);
        }
      },
      child: const LoadingIndicator(),
    );
  }

  void _loadMore(BuildContext context) {
    final VoteOptionsProvider provider = Provider.of(context, listen: false);
    provider.onLoadMoreOptions();
  }

  Widget _searchBar(BuildContext context) {
    final VoteOptionsProvider provider = Provider.of(context);
    return TextField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onSubmitted: (String value) {
        provider.onSearchSubmitted(value);
      },
      decoration: InputDecoration(
          labelText:
              RousseauLocalizations.getText(context, 'vote-search-candidate'),
          hintText: RousseauLocalizations.getText(
              context, 'vote-search-candidate-hint'),
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }

  Widget _meritsFilter(BuildContext context) {
    final VoteOptionsProvider provider = Provider.of(context);
    final List<Widget> badges = <Widget>[];
    for (int i = 0; i < BADGES_NUMBER; i++) {
      final bool active = provider.isBadgeSelected(i);
      badges.add(Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: BadgeImage(
          badgeNumber: i,
          size: 35,
          active: active,
          onTap: () => provider.onBadgeTapped(i),
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: badges,
    );
  }
}
