import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';

class Login with ChangeNotifier {
  var _isLoading = false;
  var _isLogged = false;

  Future<bool> login() {
    _isLoading = true;
    notifyListeners();

    return _doLogin();
  }

  Future<bool> _doLogin() async {
    return Future.delayed(Duration(seconds: 4), () {
      _isLoading = false;
      _isLogged = true;
      notifyListeners();
      return true;
    });
  }

  void logout() {}

  void onLogout() {}

  bool isLoggedIn() {
    return _isLogged;
  }

  bool isLoading() {
    return _isLoading;
  }
}
