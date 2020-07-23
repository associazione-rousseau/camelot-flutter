import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/account/delete_account_action_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';

class DeleteAccountDisclaimerScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/delete_account_disclaimer';
  
  @override Widget build(BuildContext context){
    final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();
    final String title = RousseauLocalizations.of(context).text('edit-account-delete');
    
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(
              RousseauLocalizations.of(context).text('unsubscribe-title'),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text(
                  RousseauLocalizations.of(context).text('unsubscribe-text'),
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ),
            SafeArea(
              child: RoundedButton(
                text: RousseauLocalizations.of(context).text('understand'),
                onPressed: () {openRoute(context, DeleteAccountActionScreen.ROUTE_NAME);},
              ),
            )
          ],
        ),
      )
    );
  }
}