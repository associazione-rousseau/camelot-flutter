import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class SuccessScreen extends StatelessWidget{
  SuccessScreen({this.message});
  String message;
  static const String ROUTE_NAME = '/success';

  @override Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        appBar: RousseauAppBar(),
        body: Padding(
        padding: const EdgeInsets.only(top:40, bottom: 15, left: 15,right: 15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25),
                    child: Text(
                      RousseauLocalizations.of(context).text(message ?? 'success-message'),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            RoundedButton(
              text: RousseauLocalizations.of(context).text('back-home'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        )
      ),
    );
  }
}