import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
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
                    login.isLoadingCode()
                        ? LoadingIndicator(Colors.red)
                        : PinPut(
                            fieldsCount: 5,
                            onClear: (code) => {},
                            onSubmit: (code) {
                              login.submitCode(code);
                            },
                          ),
                    SizedBox(height: 15.0),
                    RoundedButton(
                      text:
                          RousseauLocalizations.getText(context, 'voice-call'),
                      //onPressed: { login.voiceCall() },
                      loading: login.isWaitingForVoiceCall(),
                    ),
                    SizedBox(height: 15.0),
                    RoundedButton(
                      text:
                          RousseauLocalizations.getText(context, 're-send-sms'),
                      //onPressed: { login.resendCode() },
                      loading: login.isWaitingResendCode(),
                    ),
                    SizedBox(height: 15.0),
                    FlatButton(
                      onPressed: () { login.cancelCode(); },
                      child: Text(
                        RousseauLocalizations.getText(context, 'cancel')
                            .toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ])),
        ]));
  }

  void _maybeShowErrorMessage(BuildContext context) {
    final login = Provider.of<Login>(context, listen: false);
    if (login.hasError()) {
      String errorMessage;
      switch(login.errorState) {
        case ErrorState.CREDENTIALS_ERROR:
          errorMessage = 'error-code';
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
    UiUtil.showRousseauSnackbar(context, _scaffoldState, errorMessage);
  }
}
