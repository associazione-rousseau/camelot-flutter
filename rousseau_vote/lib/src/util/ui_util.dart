import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class UiUtil {
  static showRousseauSnackbar(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldState, String errorMessage) {
    final snackBar = SnackBar(
      content: new Text(RousseauLocalizations.getText(context, errorMessage)),
      duration: new Duration(seconds: 5),
    );
    scaffoldState.currentState.showSnackBar(snackBar);
  }
}
