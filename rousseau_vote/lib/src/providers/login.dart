import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/network/exceptions/too_many_attempts_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';
import 'package:rousseau_vote/src/store/token_store.dart';

class Login with ChangeNotifier {
  final LoginNetworkHandler _loginNetworkHandler;
  final TokenStore _tokenStore;
  LoginState _loginState;
  ErrorState _errorState;

  Login(this._loginNetworkHandler, this._tokenStore) {
    _loadInitialState();
  }

  void _loadInitialState() {
    // TODO implement persistent login
    _moveToState(
        loginState: LoginState.LOGGED_OUT,
        errorState: ErrorState.NO_ERRORS);
  }

  void _moveToState(
      {LoginState loginState,
        ErrorState errorState,
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
    _moveToState(loginState: LoginState.CREDENTIALS_LOADING);

    try {
      final loginSession =
          await _loginNetworkHandler.credentialsLogin(email, password);
      assert(loginSession != null);
      _moveToState(loginState: LoginState.CREDENTIALS_AUTHENTICATED);
    } on WrongCredentialsException {
      _moveToState(
          loginState: LoginState.LOGGED_OUT,
          errorState: ErrorState.CREDENTIALS_ERROR);
    } on DioError {
      _moveToState(
          loginState: LoginState.LOGGED_OUT,
          errorState: ErrorState.NETWORK_ERROR);
    }
    return isCredentialsAuthenticated();
  }

  Future<bool> submitCode(String code) async {
    _moveToState(loginState: LoginState.CODE_LOADING);
    try {
      final TokenResponse tokenResponse = await _loginNetworkHandler
          .submitTwoFactorCode(code);
      if(tokenResponse.hasErrors()) {
        return false;
      }
      final Token token = Token.fromTokenResponse(tokenResponse);
      this._tokenStore.onTokenFetched(token);
      if (this._tokenStore.hasValidToken()) {
        _moveToState(
            loginState: LoginState.LOGGED_IN,
            errorState: ErrorState.NO_ERRORS);
      } else {
        _moveToState(
          loginState: LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: ErrorState.INVALID_TOKEN);
      }
      return true;
    } on WrongCredentialsException {
      _moveToState(
          loginState: LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: ErrorState.CREDENTIALS_ERROR);
      return false;
    }  on TooManyAttemptsException {
      _moveToState(
          loginState: LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: ErrorState.TOO_MANY_ATTEMPTS);
      return false;
    } on DioError catch (e) {
      _moveToState(
          loginState: LoginState.CREDENTIALS_AUTHENTICATED,
          errorState: ErrorState.NETWORK_ERROR);
      return false;
    }
  }

  Future<bool> resendCode() async {
    _moveToState(loginState: LoginState.CODE_RESEND_LOADING);
    return true;
  }

  Future<bool> voiceCall() async {
    _moveToState(loginState: LoginState.CODE_VOICE_CALL_LOADING);
    return true;
  }

  void cancelCode() {
    _moveToState(loginState: LoginState.LOGGED_OUT);
  }

  bool isWaitingForVoiceCall() => this._loginState == LoginState.CODE_VOICE_CALL_LOADING;

  bool isWaitingResendCode() => this._loginState == LoginState.CODE_RESEND_LOADING;

  bool isLoggedIn() => this._loginState == LoginState.LOGGED_IN;

  bool isLoading() => this._loginState == LoginState.CREDENTIALS_LOADING;

  bool isLoadingCode() => this._loginState == LoginState.CODE_LOADING;

  bool isLastLoginFailed() => this._errorState == ErrorState.CREDENTIALS_ERROR;

  bool isLastTokenInvalid() => this._errorState == ErrorState.INVALID_TOKEN;

  bool isLastCodeSubmissionFailed() => this._errorState == ErrorState.CREDENTIALS_ERROR;

  bool hasTooManyAttempts() => this._errorState == ErrorState.TOO_MANY_ATTEMPTS;

  bool hasGenericError() => this._errorState == ErrorState.GENERIC_ERROR;

  bool isCredentialsAuthenticated() =>
      this._loginState != null &&
      this._loginState != LoginState.LOGGED_OUT &&
          this._loginState != LoginState.CREDENTIALS_LOADING;

  bool hasNetworkError() => this._errorState == ErrorState.NETWORK_ERROR;

  bool hasError() => this._errorState != ErrorState.NO_ERRORS;

  ErrorState get errorState => _errorState;

  void resetErrors({shouldNotifyListeners = false}) => _moveToState(
      errorState: ErrorState.NO_ERRORS,
      shouldNotifyListeners: shouldNotifyListeners);
}

enum ErrorState { NO_ERRORS, CREDENTIALS_ERROR, TOO_MANY_ATTEMPTS, GENERIC_ERROR, NETWORK_ERROR, INVALID_TOKEN }

enum LoginState {
  LOGGED_OUT,
  CREDENTIALS_LOADING,
  CREDENTIALS_AUTHENTICATED,
  CODE_LOADING,
  CODE_RESEND_LOADING,
  CODE_VOICE_CALL_LOADING,
  LOGGED_IN
}
