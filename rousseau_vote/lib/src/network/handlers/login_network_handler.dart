import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/exceptions/login_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/no_session_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/session_expired_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/too_many_attempts_exception.dart';
import 'package:rousseau_vote/src/network/exceptions/wrong_credentials_exception.dart';
import 'package:rousseau_vote/src/network/response/credentials_login_response.dart';
import 'package:rousseau_vote/src/network/response/has_login_response.dart';
import 'package:rousseau_vote/src/network/response/init_login_response.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';
import 'package:rousseau_vote/src/network/restclients/login_rest_client.dart';
import 'package:rousseau_vote/src/network/result/credentials_login_result.dart';
import 'package:rousseau_vote/src/network/util/open_id_util.dart';
import 'package:rousseau_vote/src/providers/login.dart';

@singleton
class LoginNetworkHandler {

  LoginNetworkHandler(Dio dio) : _loginRestClient = LoginRestClient(dio);

  final LoginRestClient _loginRestClient;
  LoginSession _loginSession;

  Future<CredentialsLoginResult> credentialsLogin(String username, String password) async {
    final String nonce = generateNonce();
    final String state = generateState();

    final InitLoginResponse initLoginResponse = await _loginRestClient.initLogin(nonce, state);
    if (initLoginResponse.hasErrors()) {
      throw LoginException(initLoginResponse.errors.first);
    }
    final LoginSession loginSession = LoginSession.fromLoginResponse(initLoginResponse);
    final Map<String, String> body = <String, String> {
      'username': username,
      'password': password,
      'rememberMe': 'on'};
    try {
      final CredentialsLoginResponse credentialsLoginResponse = await _loginRestClient
          .login(
          loginSession.sessionCode,
          loginSession.execution,
          loginSession.tabId,
          body);
      if (credentialsLoginResponse.hasErrors()) {
        // TODO check all the possible errors
        throw WrongCredentialsException();
      }
      _loginSession = LoginSession.fromLoginResponse(credentialsLoginResponse);
      return CredentialsLoginResult(loginSession: _loginSession);
    } on DioError catch(e) {
      // it succeed if it redirects passing the code as url params
      if (e.response.statusCode == 302) {
        final String redirectUrl = e.response.headers.value('Location');
        final String accessCode = _extractAccessCode(redirectUrl);
        final TokenResponse tokenResponse = await _getToken(accessCode);
        return CredentialsLoginResult(tokenResponse: tokenResponse);
      }
      rethrow;
    }
  }

  Future<TokenResponse> submitTwoFactorCode(String smsCode) async {
    if (_loginSession == null) {
      throw NoSessionException();
    }

    final String accessCode = await _getAccessCode(smsCode);
    return await _getToken(accessCode);
  }

  Future<bool> sendNewCode() async{
    if (_loginSession == null) {
      throw NoSessionException();
    }
    final CredentialsLoginResponse response = await _loginRestClient.twoFactorExtraAction(
        _loginSession.sessionCode, _loginSession.execution, _loginSession.tabId, <String, String>{'action': 'resend'});
    _loginSession = LoginSession.fromLoginResponse(response);
    return response != null;
  }

  Future<bool> voiceCall() async{
    if (_loginSession == null) {
      throw NoSessionException();
    }
    final CredentialsLoginResponse response = await _loginRestClient.twoFactorExtraAction(
        _loginSession.sessionCode, _loginSession.execution, _loginSession.tabId, {'action': 'voice_call'});
    _loginSession = LoginSession.fromLoginResponse(response);
    return response != null;
  }

  Future<TokenResponse> refreshToken(String refreshToken) async {
    try {
      return await _refreshToken(refreshToken);
    } catch (e) {
      if (e.response.data['error'] == 'invalid_grant') {
        getIt<Login>().sessionExpired();
      }
      rethrow;
    }
  }

  Future<void> logout(String refreshToken) async {
    await _loginRestClient.logout(refreshToken);
  }

  Future<String> _getAccessCode(String smsCode) async {
    final Map<String, String> body = <String, String>{ 'smsCode': smsCode };

    try {
      final CredentialsLoginResponse submitTwoFactorCodeResponse = await _loginRestClient
          .submitTwoFactorCode(
          _loginSession.sessionCode,
          _loginSession.execution,
          _loginSession.tabId,
          body);
      _loginSession = LoginSession.fromLoginResponse(submitTwoFactorCodeResponse);
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
      rethrow;
    }
    throw AssertionError('Unexpected server response');
  }

  Future<TokenResponse> _getToken(String accessCode) async {
    final Map<String, String> body = _getTokenRequestBody(accessCode: accessCode);
    return _loginRestClient.getToken(body);
  }

  Future<TokenResponse> _refreshToken(String refreshToken) async {
    final Map<String, String> body = _getTokenRequestBody(refreshToken: refreshToken, refresh:  true);
    return _loginRestClient.getToken(body);
  }

  String _extractAccessCode(String redirectUrl) {
    final String firstChunk = redirectUrl.substring(redirectUrl.indexOf('code=') + 5);
    final int endIndex = firstChunk.contains('&') ? firstChunk.indexOf('&') : firstChunk.length;
    return firstChunk.substring(0, endIndex);
  }

  Map<String, String> _getTokenRequestBody({String refreshToken, String accessCode, bool refresh = false} ) {
    return <String, String>{
      'code': accessCode,
      'refresh_token': refreshToken,
      'client_id': KEYCLOAK_CLIENT_ID,
      'redirect_uri': KEYCLOAK_REDIRECT_URI,
      'grant_type': refresh ? 'refresh_token' : 'authorization_code',
    };
  }
}


class LoginSession {

  LoginSession(this.sessionCode, this.execution, this.tabId);

  factory LoginSession._fromLoginUrl(String url) {
    final Map<String, String> params = Uri.parse(url.replaceAll(RegExp(r'&amp;'), '&')).queryParameters;
    return LoginSession(params['session_code'], params['execution'], params['tab_id']);
  }

  factory LoginSession.fromLoginResponse(HasLoginUrl response) {
    return LoginSession._fromLoginUrl(response.loginUrl);
  }

  final String sessionCode;
  final String execution;
  final String tabId;
}