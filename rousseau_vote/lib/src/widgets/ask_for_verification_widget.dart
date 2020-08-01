// This widget ask the user to upload the ID if not verified yet

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/util/verify_identity_util.dart';

class AskForVerificationWidget extends StatefulWidget {
  const AskForVerificationWidget({@required this.child});

  final Widget child;

  @override
  _AskForVerificationWidgetState createState() =>
      _AskForVerificationWidgetState();
}

class _AskForVerificationWidgetState extends State<AskForVerificationWidget>
    with AfterLayoutMixin<AskForVerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    maybeShowVerificationDialog(context, delay: 1);
  }
}
