import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'package:rousseau_vote/src/screens/account/anagraph_screen.dart';
import 'package:rousseau_vote/src/screens/account/login_info_screen.dart';
import 'package:rousseau_vote/src/screens/account/residence_screen.dart';
import 'package:rousseau_vote/src/screens/account/contact_preferences_screen.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen();

  static const String ROUTE_NAME = '/edit_account';
  //final edit-account-argss arguments;

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
        appBar: RousseauAppBar(),
        body: GraphqlQueryWidget<CurrentUser>(
          query: currentUserFull,
          builderSuccess: (CurrentUser currentUser) {
            return ListView(
              children: <Widget>[
                CardRow(
                    'Dati anagrafici', AnagraphScreen.ROUTE_NAME, currentUser),
                CardRow('Informazioni di login', LoginInfoScreen.ROUTE_NAME,
                    currentUser),
                CardRow('Informazioni di residenza', ResidenceScreen.ROUTE_NAME,
                    currentUser),
                CardRow(
                   'Preferenze notifiche email', ContactPreferencesScreen.ROUTE_NAME,currentUser),
//                CardRow('Cancella iscrizione', AnagraphScreen.ROUTE_NAME),
              ],
            );
          },
          builderLoading: () {
            return const LoadingIndicator();
          },
          builderError: (List<GraphQLError> error) {
            return Text(error.toString());
          },
        ));
  }
}

class CardRow extends StatelessWidget {
  final String text;
  final String route;
  final Object arguments;

  CardRow(this.text, this.route, this.arguments);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openRoute(context, route, arguments: arguments);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(fontSize: 22),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
