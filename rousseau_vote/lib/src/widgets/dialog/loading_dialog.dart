
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class LoadingDialog extends StatelessWidget {

  const LoadingDialog({this.titleKey});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final Widget title = titleKey != null ? Text(
      RousseauLocalizations.getText(context, titleKey),
      style: const TextStyle(color: PRIMARY_RED)) : null;
    return AlertDialog(
      title: title,
      content: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 25),
          child: LoadingIndicator(),
        ),
      )
    );
  }

}