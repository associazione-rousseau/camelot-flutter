import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class ErrorDialog extends StatelessWidget {

  const ErrorDialog(this._error);

  final String _error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      title: Text(
        RousseauLocalizations.getText(context, 'error-title'),
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Text(_error),
      elevation: 5,
      actions: <Widget>[
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'close'),
            style: const TextStyle(fontSize: 18),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop()
        ),
        Container()
      ],
    );
  }

}