import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/main/main_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';

class ThankYouDialog extends StatelessWidget {
  const ThankYouDialog({@required this.textKey});

  final String textKey;
  @override
  Widget build(BuildContext context) {
    final Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const VerticalSpace(30),
        const Icon(
          Icons.done_all,
          color: Colors.green,
        ),
        Text(
          RousseauLocalizations.getText(context, textKey),
          textAlign: TextAlign.center,
        )
      ],
    );
    final List<FlatButton> buttons = <FlatButton>[
      FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'back-home'),
          ),
          onPressed: () {
            openRoute(context, MainScreen.ROUTE_NAME, replace: true);
          })
    ];

    return AlertDialog(
      content: SingleChildScrollView(
        child: body,
      ),
      actions: buttons,
    );
  }
}
