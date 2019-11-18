import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/network/exceptions/login_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/no_session_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/response/has_login_response.dart';
import 'package:rousseau_vote/src/network/restclients/login_rest_client.dart';
import 'package:uuid/uuid.dart';

class LoginNetworkHandler {
  final Dio _dio;
  final LoginRestClient _loginRestClient;
  LoginSession _loginSession;

  LoginNetworkHandler(this._dio) : _loginRestClient = LoginRestClient(_dio);

  Future<LoginSession> credentialsLogin(String username, String password) async {
    final nonce = Uuid().v4();
    final state = Uuid().v4();

    final initLoginResponse = await _loginRestClient.initLogin(nonce, state);
    if (initLoginResponse.hasErrors()) {
      throw LoginException(initLoginResponse.errors.first);
    }
    LoginSession loginSession = LoginSession.fromLoginResponse(initLoginResponse);
    final Map<String, String> body = {
      'username': username,
      'password': password,
      'rememberMe': 'true'};
    final credentialsLoginResponse = await _loginRestClient.login(
        loginSession.sessionCode,
        loginSession.execution,
        loginSession.tabId,
        body);
    if (credentialsLoginResponse.hasErrors()) {
      print(credentialsLoginResponse.errors.first);
      throw WrongCredentialsException();
    }
    this._loginSession = LoginSession.fromLoginResponse(credentialsLoginResponse);
    return _loginSession;
  }

  Future<LoginSession> submitTwoFactorCode(String smsCode) async {
    if (this._loginSession == null) {
      throw NoSessionException();
    }
    final Map<String, String> body = { 'smsCode': smsCode };
    final credentialsLoginResponse = await _loginRestClient.submitTwoFactorCode(
        this._loginSession.sessionCode,
        this._loginSession.execution,
        this._loginSession.tabId,
        body);
    print(credentialsLoginResponse);
  }
}

class LoginSession {
  final String sessionCode;
  final String execution;
  final String tabId;

  LoginSession(this.sessionCode, this.execution, this.tabId);

  factory LoginSession._fromLoginUrl(String url) {
    final params = Uri.parse(url.replaceAll(RegExp(r'&amp;'), '&')).queryParameters;
    return LoginSession(params['session_code'], params['execution'], params['tab_id']);
  }

  factory LoginSession.fromLoginResponse(HasLoginUrl response) {
    return LoginSession._fromLoginUrl(response.loginUrl);
  }
}