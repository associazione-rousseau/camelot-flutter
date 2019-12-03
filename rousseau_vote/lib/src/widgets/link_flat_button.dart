
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/in_app_browser.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

import 'model/browser_arguments.dart';

// Button that opens a link in the in app browser
class LinkFlatButton extends StatelessWidget {

  const LinkFlatButton({ @required this.url, @required this.textKey, this.color });

  final String textKey;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final String text = RousseauLocalizations.getText(context, textKey);
    return FlatButton(
      child: Text(text, style: TextStyle(color: color)),
      onPressed: () {
        UiUtil.openLink(context, BrowserArguments(url: url, title: text, color: color));
      },
    );
  }
}
