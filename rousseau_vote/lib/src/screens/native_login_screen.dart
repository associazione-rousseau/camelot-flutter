import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logo_header.dart';
import 'package:rousseau_vote/src/widgets/vertical_scroll_view.dart';

class NativeLoginScreen extends StatefulWidget {
  @override
  _NativeLoginScreenState createState() => _NativeLoginScreenState();
}

class _NativeLoginScreenState extends State<NativeLoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _maybeShowErrorMessage(context);
    return Scaffold(
      key: _scaffoldState,
      body: VerticalScrollView(
        children: [
          RousseauLogoHeader(),
          Consumer<Login>(
              builder: (context, login, _) => Column(
                    children: <Widget>[
                      RoundedTextField(
                          hintText:
                              RousseauLocalizations.getText(context, 'email'),
                          enabled: !login.isLoading(),
                          controller: _emailTextController),
                      SizedBox(height: 15.0),
                      RoundedTextField(
                          hintText: RousseauLocalizations.getText(
                              context, 'password'),
                          obscureText: true,
                          enabled: !login.isLoading(),
                          controller: _passwordTextController),
                      SizedBox(height: 15.0),
                      RoundedButton(
                        text: RousseauLocalizations.getText(
                            context, 'login-button'),
                        loading: login.isLoading(),
                        onPressed: () {
                          login.credentialsLogin(_emailTextController.text,
                              _passwordTextController.text);
                        },
                      ),
                    ],
                  )),
          SizedBox(height: 25.0),
          Text(
            RousseauLocalizations.getText(context, 'password-forgot'),
            style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
          ),
          SizedBox(height: 25.0),
          Row(children: [
            Expanded(child: Divider(thickness: 2)),
            Expanded(
                child: Text(
                    RousseauLocalizations.getText(context, 'or').toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        color: Colors.grey))),
            Expanded(child: Divider(thickness: 2)),
          ]),
          SizedBox(height: 25.0),
          FlatButton(
            child: Text(
              RousseauLocalizations.getText(context, 'register-button')
                  .toUpperCase(),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  void _maybeShowErrorMessage(BuildContext context) {
    final login = Provider.of<Login>(context, listen: false);
    if (login.hasNetworkError()) {
      _showErrorMessage(context, 'error-network');
      login.resetErrors();
    } else if (login.isLastLoginFailed()) {
      _showErrorMessage(context, 'error-credentials');
      login.resetErrors();
    }
  }

  void _showErrorMessage(BuildContext context, String errorMessage) {
    UiUtil.showRousseauSnackbar(context, _scaffoldState, errorMessage);
  }
}
