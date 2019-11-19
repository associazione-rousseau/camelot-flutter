import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';

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
    final login = Provider.of<Login>(context, listen: false);
    if (login.hasNetworkError()) {
      final snackBar = SnackBar(
        content: new Text(RousseauLocalizations.getText(context, 'error-network')),
        duration: new Duration(seconds: 5),
      );
      _scaffoldState.currentState.showSnackBar(snackBar);
      login.resetErrors();
    }
    return Scaffold(
      key: _scaffoldState,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 500,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Image(image: AssetImage('assets/images/rousseau_red.png')),
                  SizedBox(height: 60.0),
                  Consumer<Login>(
                      builder: (context, login, _) =>
                      Column(
                        children: <Widget>[
                          RoundedTextField(
                              hintText: RousseauLocalizations.getText(context, 'email'),
                              enabled: !login.isLoading(),
                              controller: _emailTextController),
                          SizedBox(height: 15.0),
                          RoundedTextField(
                              hintText: RousseauLocalizations.getText(context, 'password'),
                              obscureText: true,
                              enabled: !login.isLoading(),
                              controller: _passwordTextController),
                          SizedBox(height: 15.0),
                          RoundedButton(
                            text: RousseauLocalizations.getText(context, 'login-button'),
                            loading: login.isLoading(),
                            onPressed: () {
                              login.login(_emailTextController.text, _passwordTextController.text);
                            },
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    RousseauLocalizations.getText(context, 'password-forgot'),
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
                  ),
                  SizedBox(height: 25.0),
                  //Row(children: [Divider(height: 5,),Text('OPPURE'), Divider()]),
                  Row(children: [
                    Expanded(child: Divider(thickness: 2)),
                    Expanded(
                        child: Text(RousseauLocalizations.getText(context, 'or').toUpperCase(),
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
                      RousseauLocalizations.getText(context, 'register-button').toUpperCase(),
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
            ),
          ),
        ),
      ),
    );
  }
}
