
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class ErrorPageWidget extends StatelessWidget {

  const ErrorPageWidget({ this.errorMessageKey = 'error-network' });

  final String errorMessageKey;

  @override
  Widget build(BuildContext context) {
    final String message = RousseauLocalizations.getText(context, errorMessageKey);
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 75),
        child: Column(
          children: <Widget>[
            Icon(Icons.cloud_off, size: 100, color: PRIMARY_RED,),
            Text(message, style: const TextStyle(fontSize: 20, color: PRIMARY_RED), textAlign: TextAlign.center,),
          ],
        ),
    );
  }

}