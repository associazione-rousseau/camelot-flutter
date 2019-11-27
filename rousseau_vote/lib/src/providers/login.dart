import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/network/exceptions/too_many_attempts_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';

class Login with ChangeNotifier {
  final LoginNetworkHandler _loginNetworkHandler;
  _LoginState _loginState;
  _ErrorState _errorState;
  Token _token;

  Login(this._loginNetworkHandler) {
    _loadInitialState();
  }

  void _loadInitialState() {
    // TODO implement persistent login
    _moveToState(
        loginState: _LoginState.LOGGED_OUT,
        errorState: _ErrorState.NO_ERRORS);
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

  Future<bool> credentialsLogin(String email, String password) async {
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

  Future<bool> submitCode(String code) async {
    _moveToState(loginState: _LoginState.CODE_LOADING);
    try {
      final TokenResponse tokenResponse = await _loginNetworkHandler
          .submitTwoFactorCode(code);
      if(tokenResponse.hasErrors()) {
        return false;
      }
      this._token = Token.fromTokenResponse(tokenResponse);
      _moveToState(
          loginState: _LoginState.LOGGED_IN,
          errorState: _ErrorState.NO_ERRORS);
      return true;
    } on WrongCredentialsException {
      _moveToState(
          loginState: _LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: _ErrorState.CREDENTIALS_ERROR);
      return false;
    }  on TooManyAttemptsException {
      _moveToState(
          loginState: _LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: _ErrorState.TOO_MANY_ATTEMPTS);
      return false;
    } on DioError catch (e) {
      _moveToState(
          loginState: _LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: _ErrorState.NETWORK_ERROR);
      return false;
    }
  }

  Future<bool> resendCode() async {
    _moveToState(loginState: _LoginState.CODE_RESEND_LOADING);
    return true;
  }

  Future<bool> voiceCall() async {
    _moveToState(loginState: _LoginState.CODE_VOICE_CALL_LOADING);
    return true;
  }

  void cancelCode() {
    _moveToState(loginState: _LoginState.LOGGED_OUT);
  }

  bool isWaitingForVoiceCall() => this._loginState == _LoginState.CODE_VOICE_CALL_LOADING;

  bool isWaitingResendCode() => this._loginState == _LoginState.CODE_RESEND_LOADING;

  bool isLoggedIn() => this._loginState == _LoginState.LOGGED_IN;

  bool isLoading() => this._loginState == _LoginState.CREDENTIALS_LOADING;

  bool isLoadingCode() => this._loginState == _LoginState.CODE_LOADING;

  bool isLastLoginFailed() => this._errorState == _ErrorState.CREDENTIALS_ERROR;

  bool isLastCodeSubmissionFailed() => this._errorState == _ErrorState.CREDENTIALS_ERROR;

  bool hasTooManyAttempts() => this._errorState == _ErrorState.TOO_MANY_ATTEMPTS;

  bool hasGenericError() => this._errorState == _ErrorState.GENERIC_ERROR;

  bool isCredentialsAuthenticated() =>
      this._loginState != null &&
      this._loginState != _LoginState.LOGGED_OUT &&
          this._loginState != _LoginState.CREDENTIALS_LOADING;

  bool hasNetworkError() => this._errorState == _ErrorState.NETWORK_ERROR;

  void resetErrors({shouldNotifyListeners = false}) => _moveToState(
      errorState: _ErrorState.NO_ERRORS,
      shouldNotifyListeners: shouldNotifyListeners);
}

enum _ErrorState { NO_ERRORS, CREDENTIALS_ERROR, TOO_MANY_ATTEMPTS, GENERIC_ERROR, NETWORK_ERROR }

enum _LoginState {
  LOGGED_OUT,
  CREDENTIALS_LOADING,
  CREDENTIALS_AUTHENTICATED,
  CODE_LOADING,
  CODE_RESEND_LOADING,
  CODE_VOICE_CALL_LOADING,
  LOGGED_IN
}
