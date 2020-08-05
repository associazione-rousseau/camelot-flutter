
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

// Generic page to show, for example, error messages as a icon text combo
class IconTextScreen extends StatelessWidget {

  const IconTextScreen({ this.messageKey, this.iconData, this.textColor = PRIMARY_RED, this.iconColor = PRIMARY_RED});

  final String messageKey;
  final IconData iconData;
  final Color textColor;
  final Color iconColor;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 75),
      child: Column(
        children: <Widget>[
          _icon(context),
          _message(context),
        ],
      ),
    );
  }

  Widget _message(BuildContext context) {
    final String message = RousseauLocalizations.getText(context, messageKey);
    return message != null ? Text(message, style: TextStyle(fontSize: 20, color: textColor), textAlign: TextAlign.center,) : Container();
  }

  Widget _icon(BuildContext context) {
    return iconData != null ? Icon(iconData, size: 100, color: iconColor,) : Container();
  }
}