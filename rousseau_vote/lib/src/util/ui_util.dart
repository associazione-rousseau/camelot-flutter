import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';
import 'package:rousseau_vote/src/widgets/model/browser_arguments.dart';

class UiUtil {
  static void showRousseauSnackbar(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldState, String errorMessage) {
    final SnackBar snackBar = SnackBar(
      content: Text(RousseauLocalizations.getText(context, errorMessage)),
      duration: const Duration(seconds: 5),
    );
    scaffoldState.currentState.showSnackBar(snackBar);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat.yMMMMEEEEd().add_jm().format(dateTime);
  }

  static void openLink(BuildContext context, BrowserArguments arguments) {
    Navigator.of(context).pushNamed(InAppBrowser.ROUTE_NAME, arguments: arguments);
  }
}
