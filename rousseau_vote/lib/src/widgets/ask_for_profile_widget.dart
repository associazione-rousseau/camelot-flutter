// This widget ask the user to upload the ID if not verified yet

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';

class AskForProfileWidget extends StatefulWidget {
  const AskForProfileWidget({@required this.child});

  final Widget child;

  @override
  _AskForProfileWidgetState createState() =>
      _AskForProfileWidgetState();
}

class _AskForProfileWidgetState extends State<AskForProfileWidget>
    with AfterLayoutMixin<AskForProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    maybeShowCompileProfileDialog(context, delay: 1);
  }
}
