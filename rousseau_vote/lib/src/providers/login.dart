import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';

class Login with ChangeNotifier {
  final LoginNetworkHandler _loginNetworkHandler;
  _LoginState _loginState;
  _ErrorState _errorState;

  Login(this._loginNetworkHandler) {
    _loginState = _loadInitialState();
    _errorState = _ErrorState.NO_ERRORS;
  }

  _LoginState _loadInitialState() {
    // TODO implement persistent login
    return _LoginState.LOGGED_OUT;
  }

  Future<bool> login(String email, String password) async {
    _moveToState(loginState: _LoginState.CREDENTIALS_LOADING);

    try {
      final loginSession =
          await _loginNetworkHandler.credentialsLogin(email, password);
      assert(loginSession != null);
      _moveToState(loginState: _LoginState.CREDENTIALS_AUTHENTICATED);
    } on WrongCredentialsException {
      _moveToState(
          loginState: _LoginState.LOGGED_OUT,
          errorState: _ErrorState.CREDENTIALS_ERROR);
    } on DioError {
      _moveToState(
          loginState: _LoginState.LOGGED_OUT,
          errorState: _ErrorState.NETWORK_ERROR);
    }
    return isCredentialsAuthenticated();
  }

  void _moveToState(
      {_LoginState loginState,
      _ErrorState errorState,
      bool shouldNotifyListeners = true}) {
    if (loginState != null) {
      this._loginState = loginState;
    }
    if (errorState != null) {
      this._errorState = errorState;
    }
    if (shouldNotifyListeners) {
      notifyListeners();
    }
  }

  bool isLoggedIn() => this._loginState == _LoginState.LOGGED_IN;

  bool isLoading() => this._loginState == _LoginState.CREDENTIALS_LOADING;

  bool isLastLoginFailed() => this._errorState == _ErrorState.CREDENTIALS_ERROR;

  bool isCredentialsAuthenticated() =>
      this._loginState == _LoginState.CREDENTIALS_AUTHENTICATED ||
          this._loginState == _LoginState.CODE_LOADING;

  bool hasNetworkError() => this._errorState == _ErrorState.NETWORK_ERROR;

  void resetErrors({shouldNotifyListeners = false}) => _moveToState(
      errorState: _ErrorState.NO_ERRORS,
      shouldNotifyListeners: shouldNotifyListeners);
}

enum _ErrorState { NO_ERRORS, CREDENTIALS_ERROR, GENERIC_ERROR, NETWORK_ERROR }

enum _LoginState {
  LOGGED_OUT,
  CREDENTIALS_LOADING,
  CREDENTIALS_AUTHENTICATED,
  CODE_LOADING,
  LOGGED_IN
}
