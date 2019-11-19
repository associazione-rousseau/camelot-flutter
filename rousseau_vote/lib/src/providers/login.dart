import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';

class Login with ChangeNotifier {
  final LoginNetworkHandler _loginNetworkHandler;
  LoginState _currentState;

  Login(this._loginNetworkHandler) {
    _currentState = _loadInitialState();
  }

  LoginState _loadInitialState() {
    // TODO implement persistent login
    return LoginState.LOGGED_OUT;
  }

  Future<bool> login(String email, String password) async {
    _moveToState(LoginState.LOADING);
    notifyListeners();

    try {
      final loginSession =
          await _loginNetworkHandler.credentialsLogin(email, password);
      assert(loginSession != null);
      _moveToState(LoginState.LOGGED_IN);
    } on WrongCredentialsException {
      _moveToState(LoginState.CREDENTIALS_ERROR);
    } on DioError catch(e) {
      _moveToState(LoginState.NETWORK_ERROR);
    }
    return isLoggedIn();
  }

  void _moveToState(LoginState newState, {bool shouldNotifyListeners = true}) {
    this._currentState = newState;
    if (shouldNotifyListeners) {
      notifyListeners();
    }
  }

  bool isLoggedIn() => this._currentState == LoginState.LOGGED_IN;

  bool isLoading() => this._currentState == LoginState.LOADING;

  bool isLastLoginFailed() =>
      this._currentState == LoginState.CREDENTIALS_ERROR;

  bool hasNetworkError() => this._currentState == LoginState.NETWORK_ERROR;

  void resetErrors({shouldNotifyListeners = false}) =>
      _moveToState(LoginState.LOGGED_OUT,
          shouldNotifyListeners: shouldNotifyListeners);
}

enum LoginState {
  LOGGED_OUT,
  LOADING,
  NETWORK_ERROR,
  CREDENTIALS_ERROR,
  GENERIC_ERROR,
  LOGGED_IN
}
