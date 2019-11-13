import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/screens/native_login_screen.dart';
import 'package:rousseau_vote/src/screens/web_login_screen.dart';

import '../config/app_constants.dart' as AppConstants;

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return AppConstants.USE_NATIVE_LOGIN ? NativeLoginScreen() : WebLoginScreen();
  }
}
