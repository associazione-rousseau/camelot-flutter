import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class UiUtil {
  static void showRousseauSnackbar(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldState, String errorMessage) {
    final SnackBar snackBar = SnackBar(
      content: Text(RousseauLocalizations.getText(context, errorMessage)),
      duration: Duration(seconds: 5),
    );
    scaffoldState.currentState.showSnackBar(snackBar);
  }
}
