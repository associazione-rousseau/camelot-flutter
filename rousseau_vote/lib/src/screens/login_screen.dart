import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/screens/native_2fa_screen.dart';
import 'package:rousseau_vote/src/screens/native_login_screen.dart';
import 'package:rousseau_vote/src/screens/web_login_screen.dart';

import 'package:rousseau_vote/src/config/app_constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return USE_NATIVE_LOGIN ? _nativeLoginScreen(context) : WebLoginScreen();
  }

  Widget _nativeLoginScreen(BuildContext context) {
    final login = Provider.of<Login>(context);
    return login.isCredentialsAuthenticated() ? Native2FaScreen() : NativeLoginScreen();
  }
}
