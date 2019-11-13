

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/screens/polls_screen.dart';

class Login with ChangeNotifier {
  var _isLogged = false;
  var _isLoading = false;

  void login(String code) async {
    _isLoading = true;
    notifyListeners();

    sleep(Duration(seconds: 3));

    _isLogged = true;
    _isLoading = false;
    notifyListeners();
  }

  void logout() {

  }

  bool isLoggedIn() {
    return _isLogged;
  }

  bool isLoading() {
    return _isLoading;
  }
}