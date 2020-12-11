import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/activist/activist_search_widget.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/user/user_card.dart';

class ActivistsScreen extends StatelessWidget {
  const ActivistsScreen();

  static const String ROUTE_NAME = '/activists';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
//            ActivistSearchWidget(),
            RousseauList<ActivistsSearchProvider, User>(
              primary: false,
              itemBuilder: (BuildContext context, User user) => UserCard(
                  user: user,
                  onTap: (BuildContext context) {
                    Provider.of<SearchSuggestionsProvider>(context,
                            listen: false)
                        .onProfileOpened(user);
                    openProfile(context, user.slug);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
