
import 'dart:convert';

import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/models/access_token_info.dart';
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';

class TokenStore with InitializeOnStartup {

  TokenStore(this._secureStorage);

  Token _token;
  AccessTokenInfo _accessTokenInfo;
  final SecureStorage _secureStorage;

  Future<void> onTokenFetched(Token token) {
    setToken(token);
    return _secureStorage.storeToken(token);
  }

  void setToken(Token token) {
    _token = token;
    _accessTokenInfo = AccessTokenInfo.fromAccessToken(token.accessToken);
  }

  bool hasValidToken() {
    return _token != null && _token.isValid();
  }

  Future<String> getAccessToken() {
    if (_accessTokenInfo.isExpired()) {

    }
    return Future<String>.value(_token?.accessToken);
  }

  @override
  Future<void> doInitialize() async {
    final String serializedToken = await _secureStorage.readToken();
    if(serializedToken != null) {
      _token = Token.fromJson(jsonDecode(serializedToken));
      if(_token.isExpired()) {
        // TODO refresh token
      }
    }
  }
}