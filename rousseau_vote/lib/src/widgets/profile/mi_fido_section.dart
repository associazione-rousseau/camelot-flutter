import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/user/user_subscriptions_list.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/mi_fido_icon_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/profile_section_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/subscriptions_sheet.dart';

class MiFidoSection extends StatelessWidget {
  const MiFidoSection({@required this.userProfile, this.isCurrentUser = false});

  final UserProfile userProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionWidget(
        child: Column(
      children: <Widget>[
        ConditionalWidget(
            condition: !isCurrentUser,
            child: Center(
                child: MiFidoIconWidget(
              userProfile: userProfile,
              size: 30,
            ))),
        const VerticalSpace(10),
        InkResponse(
          child: Text(_miFidoString(context)),
          onTap: () => _onUsersTapped(context),
        ),
        const VerticalSpace(10),
      ],
    ));
  }

  String _miFidoString(BuildContext context) {
    if (userProfile.subscriptionCount == 0) {
      return RousseauLocalizations.getText(context, 'mi-fido-count-zero');
    }
    if (userProfile.subscriptionCount == 1) {
      return RousseauLocalizations.getTextFormatted(
          context, 'mi-fido-count-one', <String>[
        userProfile.firstSubscriber.fullName,
      ]);
    }
    return RousseauLocalizations.getTextFormatted(
        context, 'mi-fido-count-plural', <dynamic>[
      userProfile.firstSubscriber.fullName,
      userProfile.subscriptionCount
    ]);
  }

  void _onUsersTapped(BuildContext context) {
    final GraphqlFetcher<UserSubscriptionsList> fetcher =
        GraphqlFetcher<UserSubscriptionsList>(
            query: userSubscriptions,
            variables: <String, dynamic>{'id': userProfile.slug, 'first': 10});

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) =>
            SubscriptionsSheet<UserSubscriptionsList>(fetcher: fetcher));
  }
}
