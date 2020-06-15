import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/widgets/label_value.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';

class LoginInfoScreen extends StatelessWidget {
  CurrentUser currentUser;
  LoginInfoScreen(this.currentUser) {
    _emailController = TextEditingController(text: currentUser.email);
    _phoneNumberController =
        TextEditingController(text: currentUser.phoneNumber);
  }

  static const String ROUTE_NAME = '/account_login_info';
  TextEditingController _emailController;
  TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RousseauAppBar(),
      body: ListView(
        children: <Widget>[
          LabelValue(_emailController, 'Email', true),
          LabelValue(_phoneNumberController, 'Numero di telefono', true)
        ],
      ),
    );
  }
}
