import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/user/subscribed_list.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/util/mi_fido_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/profile_section_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/users_sheet.dart';
import 'package:rousseau_vote/src/widgets/user/user_row.dart';

class SubscribedSection extends StatelessWidget {
  const SubscribedSection({@required this.userProfile});

  final UserProfile userProfile;

  static const int PROFILES_SHOWN = 3;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionWidget(
      child: Column(children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            RousseauLocalizations.getText(context, 'subscribed-title'),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const Divider(
          color: Colors.black38,
        ),
        const VerticalSpace(10),
        _body(context),
      ]),
//        child: Text(subscribedString(context, userProfile)),
    );
  }

  Widget _body(BuildContext context) {
    if (userProfile.subscribedCount == 0) {
      return Text(subscribedString(context, userProfile));
    }
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index == _cachedProfilesCount()) {
            return _seeMoreWidget(context);
          }
          return UserRow(
              user: userProfile.userPublicSubscriptions.nodes[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const VerticalSpace(10),
        itemCount: _itemCount());
  }

  int _itemCount() {
    return _totalProfilesCount() < PROFILES_SHOWN
        ? _cachedProfilesCount()
        : _cachedProfilesCount() + 1;
  }

  int _cachedProfilesCount() =>
      userProfile.userPublicSubscriptions.nodes.length;

  int _totalProfilesCount() => userProfile.userPublicSubscriptions.totalCount;

  Widget _seeMoreWidget(BuildContext context) {
    final int delta = _totalProfilesCount() - PROFILES_SHOWN;
    final String text = RousseauLocalizations.getTextFormatted(
        context, 'and-more', <int>[delta]);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkResponse(
          onTap: () => _onUsersTapped(context),
          child: Center(child: Text(text))),
    );
  }

  void _onUsersTapped(BuildContext context) {
    final GraphqlFetcher<SubscribedList> fetcher =
    GraphqlFetcher<SubscribedList>(
        query: userSubscribedList,
        variables: <String, dynamic>{'id': userProfile.slug, 'first': 10});

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) =>
            UsersSheet<SubscribedList>(fetcher: fetcher));
  }
}
