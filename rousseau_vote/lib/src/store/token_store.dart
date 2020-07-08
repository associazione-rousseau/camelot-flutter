
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/models/access_token_info.dart';
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';

@singleton
class TokenStore with InitializeOnStartup {

  TokenStore(this._secureStorage, this._loginNetworkHandler);

  Token _token;
  AccessTokenInfo _accessTokenInfo;
  final SecureStorage _secureStorage;
  final LoginNetworkHandler _loginNetworkHandler;

  Future<void> onTokenFetched(Token token) {
    setToken(token);
    return _secureStorage.storeToken(token);
  }

  void deleteToken() {
    _token = null;
    _secureStorage.deleteToken();
  }

  void setToken(Token token) {
    _token = token;
    _accessTokenInfo = AccessTokenInfo.fromAccessToken(token.accessToken);
  }

  bool hasValidToken() {
    return _token != null && _token.isValid();
  }

  Future<String> getAccessToken() async {
    if (_accessTokenInfo.isExpired()) {
      final TokenResponse tokenResponse =
      await _loginNetworkHandler.refreshToken(_token.refreshToken);
      if (tokenResponse.hasErrors()) {
        return null;
      }
      final Token token = Token.fromTokenResponse(tokenResponse);
      onTokenFetched(token);
    }
    return _token?.accessToken;
  }

  String getUserId() {
    return _accessTokenInfo != null ? _accessTokenInfo.sub : null;
  }

  String getUserFullName() {
    return _accessTokenInfo != null ? _accessTokenInfo.name : null;
  }

  @override
  Future<void> doInitialize() async {
    final String serializedToken = await _secureStorage.readToken();
    if(serializedToken != null) {
      final Token token  = Token.fromJson(jsonDecode(serializedToken));
      setToken(token);
      if(_token.isExpired()) {
        // TODO refresh token
      }
    }
  }
}