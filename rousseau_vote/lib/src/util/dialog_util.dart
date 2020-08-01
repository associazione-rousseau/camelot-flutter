
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

Future<void> showAlertDialog(BuildContext context,
    {String titleKey,
      String messageKey,
      String buttonKey1,
      String buttonKey2,
      Function buttonAction1,
      Function buttonAction2,
      bool barrierDismissible = true }) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible, // user must tap button!
    builder: (BuildContext context) {
      final String title = RousseauLocalizations.getText(context, titleKey);
      final String message = RousseauLocalizations.getText(context, messageKey);
      final String buttonText1 =
      RousseauLocalizations.getText(context, buttonKey1);
      final String buttonText2 =
      RousseauLocalizations.getText(context, buttonKey2);
      return Platform.isIOS ?
      iosAlertDialog(title, message, buttonText1, buttonText2, buttonAction1, buttonAction2)
          : androidAlertDialog(title, message, buttonText1, buttonText2, buttonAction1, buttonAction2);
    },
  );
}

CupertinoAlertDialog iosAlertDialog(String title, String message, String buttonText1,
    String buttonText2, Function buttonAction1, Function buttonAction2) {
  final List<CupertinoDialogAction> actions = <CupertinoDialogAction>[];
  if (buttonText1 != null) {
    actions.add(CupertinoDialogAction(
      child: Text(buttonText1),
      onPressed: buttonAction1,
    ));
  }
  if (buttonText2 != null) {
    actions.add(CupertinoDialogAction(
      child: Text(buttonText2),
      onPressed: buttonAction2,
    ));
  }
  return CupertinoAlertDialog(
    title: Text(title),
    content: Text(message),
    actions: actions,
  );
}

AlertDialog androidAlertDialog(String title, String message, String buttonText1,
    String buttonText2, Function buttonAction1, Function buttonAction2) {
  final List<FlatButton> buttons = <FlatButton>[];
  if (buttonText1 != null) {
    buttons.add(FlatButton(
      child: Text(buttonText1),
      onPressed: buttonAction1,
    ));
  }
  if (buttonText2 != null) {
    buttons.add(FlatButton(
      child: Text(buttonText2),
      onPressed: buttonAction2,
    ));
  }
  return AlertDialog(
    title: title != null ? Text(title) : null,
    content: SingleChildScrollView(
      child: message != null ? Text(message) : null,
    ),
    actions: buttons,
  );
}