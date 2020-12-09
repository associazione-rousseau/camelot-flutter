import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/core/search_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/badge_image.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/user/user_card.dart';

class ActivistsScreen extends StatelessWidget {
  const ActivistsScreen();

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      body: ChangeNotifierProvider<ActivistsSearchProvider>(
        create: (BuildContext context) => ActivistsSearchProvider(),
        child: Consumer<ActivistsSearchProvider>(
          builder: (BuildContext context, ActivistsSearchProvider provider,
                  Widget child) =>
              SingleChildScrollView(
                child: Column(
            children: <Widget>[
                const VerticalSpace(20),
                _filtersHeader(context, provider),
                const VerticalSpace(20),
                RousseauList<ActivistsSearchProvider, User>(
                      primary: false,
                      itemBuilder: (BuildContext context, User user) =>
                          UserCard(user: user, onTap: (_) => openProfile(context, user.slug),),
                    ),
            ],
          ),
              ),
        ),
      ),
    );
  }

  Widget _filtersHeader(
      BuildContext context, ActivistsSearchProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SearchWidget(
            labelTextKey: 'activist-search-by-name',
            hintTextKey: 'activist-search-by-name-hint',
            onSubmitted: (String word) => provider.onSearch(word),
          ),
          const VerticalSpace(15),
          _meritsFilter(context),
        ],
      ),
    );
  }

  Widget _meritsFilter(BuildContext context) {
    final ActivistsSearchProvider provider = Provider.of(context);
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
