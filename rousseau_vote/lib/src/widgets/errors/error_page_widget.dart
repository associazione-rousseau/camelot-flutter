
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/widgets/core/icon_text_screen.dart';

class ErrorPageWidget extends StatelessWidget {

  const ErrorPageWidget({ this.errorMessageKey = 'error-network' });

  final String errorMessageKey;

  @override
  Widget build(BuildContext context) {
    return IconTextScreen(iconData: Icons.cloud_off, messageKey: errorMessageKey,);
  }

}