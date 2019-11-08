import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

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
              RoundedTextField(hintText: "Email"),
              SizedBox(height: 15.0),
              RoundedTextField(hintText: "Password", obscureText: true),
              SizedBox(height: 15.0),
              RoundedButton(text: "Entra"),
              SizedBox(height: 25.0),
              Text(
                'Hai dimenticato la password?',
                style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
              ),
              SizedBox(height: 25.0),
              //Row(children: [Divider(height: 5,),Text('OPPURE'), Divider()]),
              Row(children: [
                Expanded(child: Divider(thickness: 2)),
                Expanded(
                    child: Text('OPPURE',
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
                  "REGISTRATI",
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
