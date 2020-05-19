import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';

void showRousseauSnackbar(BuildContext context,
    GlobalKey<ScaffoldState> scaffoldState, String errorMessage) {
  final SnackBar snackBar = SnackBar(
    content: Text(RousseauLocalizations.getText(context, errorMessage)),
    duration: const Duration(seconds: 5),
  );

  scaffoldState.currentState.showSnackBar(snackBar);
}

String formatDate(BuildContext context, DateTime dateTime) {
  return DateFormat.yMMMd(RousseauLocalizations.of(context).currentLanguage)
      .addPattern(" '-' ")
      .add_jm()
      .format(dateTime);
}

void openUrlInternal(BuildContext context, String url) {
  openLink(context, BrowserArguments(url: url));
}

void openLink(BuildContext context, BrowserArguments arguments) {
  Navigator.of(context)
      .pushNamed(InAppBrowser.ROUTE_NAME, arguments: arguments);
}

void openRoute(BuildContext context, String route, {Object arguments}) {
  Navigator.of(context).pushNamed(route, arguments: arguments);
}
