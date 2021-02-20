import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/config/links.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/util/open_id_util.dart';
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
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _maybeShowErrorMessage(context);
    return Scaffold(
      key: _scaffoldState,
      body: VerticalScrollView(
        children: <Widget>[
          RousseauLogoHeader(),
          Consumer<Login>(
              builder: (BuildContext context, Login login, _) => AutofillGroup(
                child: Column(
                      children: <Widget>[
                        RoundedTextField(
                            hintText:
                                RousseauLocalizations.getText(context, 'email'),
                            autofillHints: const <String>[AutofillHints.username, AutofillHints.email],
                            enabled: !login.isLoading(),
                            controller: _emailTextController),
                        const SizedBox(height: 15.0),
                        RoundedTextField(
                            hintText: RousseauLocalizations.getText(
                                context, 'password'),
                            autofillHints: const <String>[AutofillHints.password],
                            obscureText: true,
                            enabled: !login.isLoading(),
                            controller: _passwordTextController),
                        const SizedBox(height: 15.0),
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
                    ),
              )),
          const SizedBox(height: 25.0),
          GestureDetector(
            child: Text(
              RousseauLocalizations.getText(context, 'password-forgot'),
              style: const TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
            ),
            onTap: openUrlAction(context, RESET_PASSWORD),
          ),
          const SizedBox(height: 25.0),
          Row(children: <Widget>[
            const Expanded(child: Divider(thickness: 2)),
            Expanded(
                child: Text(
                    RousseauLocalizations.getText(context, 'or').toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        color: Colors.grey))),
            const Expanded(child: Divider(thickness: 2)),
          ]),
          const SizedBox(height: 25.0),
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
            onPressed: openUrlAction(context, generateRegisterUrl()),
          )
        ],
      ),
    );
  }

  void _maybeShowErrorMessage(BuildContext context) {
    final Login login = Provider.of<Login>(context, listen: false);
    if (login.hasError()) {
      String errorMessage;
      switch (login.errorState) {
        case ErrorState.CREDENTIALS_ERROR:
          errorMessage = 'error-credentials';
          break;
        case ErrorState.TOO_MANY_ATTEMPTS:
          errorMessage = 'error-too-many-attempts';
          break;
        case ErrorState.GENERIC_ERROR:
          errorMessage = 'error-generic';
          break;
        case ErrorState.NETWORK_ERROR:
          errorMessage = 'error-network';
          break;
        case ErrorState.INVALID_TOKEN:
          errorMessage = 'error-invalid-token';
          break;
        default:
          errorMessage = 'error-generic';
      }

      _showErrorMessage(context, errorMessage);
      login.resetErrors();
    }
  }

  void _showErrorMessage(BuildContext context, String errorMessage) {
    showRousseauSnackbar(context, _scaffoldState, errorMessage);
  }
}
