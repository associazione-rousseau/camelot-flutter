import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/screens/account/anagraph_screen.dart';
import 'package:rousseau_vote/src/screens/account/login_info_screen.dart';
import 'package:rousseau_vote/src/screens/account/residence_screen.dart';
import 'package:rousseau_vote/src/screens/account/contact_preferences_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/providers/current_user_provider.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class EditAccountScreen extends StatelessWidget {

  static const String ROUTE_NAME = '/edit_account';

  @override
  Widget build(BuildContext context) {
    final String title = RousseauLocalizations.of(context).text(
        'drawer-edit-account');

    final CurrentUserProvider provider = Provider.of<CurrentUserProvider>(context);

    final CurrentUser currentUser = provider.getCurrentUser();

    Widget body;

    if (currentUser != null) {
      body = _currentUserBody(currentUser);
    } else if (provider.isLoading()) {
      body = _loadingBody();
    } else {
      body = _errorBody();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }

  Widget _errorBody() {
    return const Text('Error');
  }

  Widget _loadingBody() {
    return const LoadingIndicator();
  }

  Widget _currentUserBody(CurrentUser currentUser) {
    return ListView(
              children: <Widget>[
                CardRow(
                    'Dati anagrafici', AnagraphScreen.ROUTE_NAME),
                CardRow('Informazioni di login', LoginInfoScreen.ROUTE_NAME),
                CardRow('Informazioni di residenza', ResidenceScreen.ROUTE_NAME),
                CardRow('Preferenze notifiche email', ContactPreferencesScreen.ROUTE_NAME)
//                CardRow('Cancella iscrizione', AnagraphScreen.ROUTE_NAME),
              ],
            );
    // return Text(currentUser.fullName);
  }
}

class CardRow extends StatelessWidget {
  final String text;
  final String route;

  CardRow(this.text, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openRoute(context, route);
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