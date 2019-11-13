import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';

class NativeLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/images/rousseau_red.png')),
              SizedBox(height: 60.0),
              Consumer<Login>(
                  builder: (context, login, _) =>
                  Column(
                    children: <Widget>[
                      RoundedTextField(hintText: RousseauLocalizations.getText(context, 'email'), enabled: !login.isLoading()),
                      SizedBox(height: 15.0),
                      RoundedTextField(hintText: RousseauLocalizations.getText(context, 'password'), obscureText: true, enabled: !login.isLoading()),
                      SizedBox(height: 15.0),
                      RoundedButton(
                        text: RousseauLocalizations.getText(context, 'loginButton'),
                        loading: login.isLoading(),
                        onPressed: () {
                          login.login();
                        },
                      ),
                    ],
                  )
              ),
              SizedBox(height: 25.0),
              Text(
                RousseauLocalizations.getText(context, 'forgotPassword'),
                style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
              ),
              SizedBox(height: 25.0),
              //Row(children: [Divider(height: 5,),Text('OPPURE'), Divider()]),
              Row(children: [
                Expanded(child: Divider(thickness: 2)),
                Expanded(
                    child: Text(RousseauLocalizations.getText(context, 'orUpperCase'),
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
                  RousseauLocalizations.getText(context, 'register'),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
