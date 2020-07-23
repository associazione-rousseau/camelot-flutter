import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class RousseauDialog extends StatelessWidget {

  const RousseauDialog(this._action, this.title, this.message, this.buttonText);
  
  final Function _action;
  final String title;
  final String message;
  final String buttonText;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      title: Text(RousseauLocalizations.getText(context, title)),
      content: Text(RousseauLocalizations.getText(context, message)),
      actions: <Widget>[
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, buttonText),
            style: const TextStyle(fontSize: 18),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () { 
            Navigator.of(context).pop();
            return _action();
          }
        ),
      ],
    );
  }
}