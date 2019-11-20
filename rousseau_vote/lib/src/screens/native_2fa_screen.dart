import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logo_header.dart';
import 'package:rousseau_vote/src/widgets/vertical_scroll_view.dart';

class Native2FaScreen extends StatefulWidget {
  @override
  _Native2FaScreenState createState() => _Native2FaScreenState();
}

class _Native2FaScreenState extends State<Native2FaScreen> {
  final _scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _maybeShowErrorMessage(context);
    return Scaffold(
        key: _scaffoldState,
        body: VerticalScrollView(children: [
          RousseauLogoHeader(),
          Consumer<Login>(
              builder: (context, login, _) => Column(children: <Widget>[
                Text("Insert code")
              ]))
        ]));
  }

  void _maybeShowErrorMessage(BuildContext context) {
    final login = Provider.of<Login>(context, listen: false);
    if (login.hasNetworkError()) {
      _showErrorMessage(context, 'error-network');
      login.resetErrors();
    } else if (login.isLastLoginFailed()) {
      _showErrorMessage(context, 'error-code');
      login.resetErrors();
    }
  }

  void _showErrorMessage(BuildContext context, String errorMessage) {
    UiUtil.showRousseauSnackbar(context, _scaffoldState, errorMessage);
  }
}
