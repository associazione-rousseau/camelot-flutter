import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/user/user_subscriptions_list.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/util/mi_fido_util.dart';
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
          child: Text(subscriberString(context, userProfile)),
          onTap: () => _onUsersTapped(context),
        ),
        const VerticalSpace(10),
      ],
    ));
  }

  void _onUsersTapped(BuildContext context) {
    if (userProfile.subscriptionCount == 0) {
      return;
    }
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
