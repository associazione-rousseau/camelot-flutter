import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/arguments/activist_search_arguments.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/profile_search.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/activist/activist_search_widget.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/core/search_widget.dart';
import 'package:rousseau_vote/src/widgets/profile/badge_image.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/user/user_card.dart';

class ActivistsScreen extends StatelessWidget {
  const ActivistsScreen({ this.arguments });

  final ActivistSearchArguments arguments;

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      body: ChangeNotifierProvider<ActivistsSearchProvider>(
        create: (BuildContext context) => ActivistsSearchProvider(arguments: arguments),
        child: Consumer<ActivistsSearchProvider>(
          builder: (BuildContext context, ActivistsSearchProvider provider,
                  Widget child) =>
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
            children: <Widget>[
                ActivistSearchWidget(),
                RousseauList<ActivistsSearchProvider, User>(
                      primary: false,
                      itemBuilder: (BuildContext context, User user) =>
                          UserCard(user: user, onTap: (BuildContext context) {
                            Provider.of<SearchSuggestionsProvider>(context, listen: false).onProfileOpened(user);
                            openProfile(context, user.slug);
                          }),
                    ),
            ],
          ),
              ),
        ),
      ),
    );
  }
}
