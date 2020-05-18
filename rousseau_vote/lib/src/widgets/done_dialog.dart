import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

class DoneDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      title: Text(
        RousseauLocalizations.getText(context, 'vote-already-done'),
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Text(RousseauLocalizations.getText(context, 'vote-complete'),),
      elevation: 5,
      actions: <Widget>[
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'back'),
            style: const TextStyle(fontSize: 18),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => goPolls(context)
        ),
        Container()
      ],
    );
  }

  void goPolls(BuildContext context) {
    UiUtil.openRoute(
        context, 
        PollsScreen.ROUTE_NAME, 
        null
    );
  }

}