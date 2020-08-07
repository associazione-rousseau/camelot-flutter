
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class DismissableDialog extends StatelessWidget {

  const DismissableDialog({ this.titleKey, this.body });

  final String titleKey;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final Widget title = titleKey != null ? Text(
      RousseauLocalizations.getText(context, titleKey),
      style: const TextStyle(color: PRIMARY_RED),
    ) : null;
    final List<FlatButton> buttons = <FlatButton>[
      FlatButton(
        child: Text(
          RousseauLocalizations.getText(context, 'back'),
        ),
        onPressed: () => Navigator.pop(context),
      )
    ];

    return AlertDialog(
      title: title,
      content: SingleChildScrollView(
        child: body,
      ),
      actions: buttons,
    );
  }
  
}