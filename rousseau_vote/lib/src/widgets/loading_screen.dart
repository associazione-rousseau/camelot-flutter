import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

/// A screen to display that a loading is in progress.
/// Can have a custom 'message' (defaults to 'Loading')
class LoadingScreen extends StatelessWidget {
  final String messageKey;

  LoadingScreen({this.messageKey = 'genericLoading'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 5,
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                RousseauLocalizations.of(context).text(this.messageKey),
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
