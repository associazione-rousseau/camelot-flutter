import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/network/exceptions/login_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/no_session_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/too_many_attempts_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/response/has_login_response.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';
import 'package:rousseau_vote/src/network/restclients/login_rest_client.dart';
import 'package:uuid/uuid.dart';

class LoginNetworkHandler {
  final LoginRestClient _loginRestClient;
  LoginSession _loginSession;

  LoginNetworkHandler(Dio dio) : _loginRestClient = LoginRestClient(dio);

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
      'rememberMe': 'on'};
    final credentialsLoginResponse = await _loginRestClient.login(
        loginSession.sessionCode,
        loginSession.execution,
        loginSession.tabId,
        body);
    if (credentialsLoginResponse.hasErrors()) {
      // TODO check all the possible errors
      throw WrongCredentialsException();
    }
    this._loginSession = LoginSession.fromLoginResponse(credentialsLoginResponse);
    return _loginSession;
  }

  Future<TokenResponse> submitTwoFactorCode(String smsCode) async {
    if (this._loginSession == null) {
      throw NoSessionException();
    }

    final String accessCode = await _getAccessCode(smsCode);
    return await _getToken(accessCode);
  }

  Future<String> _getAccessCode(String smsCode) async {
    final Map<String, String> body = { 'smsCode': smsCode };

    try {
      final submitTwoFactorCodeResponse = await _loginRestClient
          .submitTwoFactorCode(
          this._loginSession.sessionCode,
          this._loginSession.execution,
          this._loginSession.tabId,
          body);
      this._loginSession = LoginSession.fromLoginResponse(submitTwoFactorCodeResponse);
      if (submitTwoFactorCodeResponse.hasErrors()) {
        // TODO check all the possible errors
        if (submitTwoFactorCodeResponse.errors.first == 'phone-two-factor.err.too-many-code-attempts') {
          throw TooManyAttemptsException();
        }
        throw WrongCredentialsException();
      }
    } on DioError catch(e) {
      // it succeed if it redirects passing the code as url params
      if (e.response.statusCode == 302) {
        final String redirectUrl = e.response.headers.value('Location');
        return _extractAccessCode(redirectUrl);
      }
      throw e;
    }
    throw AssertionError('Unexpected server response');
  }

  Future<TokenResponse> _getToken(String accessCode) async {
    final Map<String, String> body = _getTokenRequestBody(accessCode);
    return _loginRestClient.getToken(body);
  }

  String _extractAccessCode(String redirectUrl) {
    final String firstChunk = redirectUrl.substring(redirectUrl.indexOf('code=') + 5);
    final int endIndex = firstChunk.indexOf('&') != -1 ? firstChunk.indexOf('&') : firstChunk.length;
    return firstChunk.substring(0, endIndex);
  }

  Map<String, String> _getTokenRequestBody(String accessCode) {
    return {
      'code': accessCode,
      'client_id': KEYCLOAK_CLIENT_ID,
      'redirect_uri': KEYCLOAK_REDIRECT_URI,
      'grant_type': 'authorization_code',
    };
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