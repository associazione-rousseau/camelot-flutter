
import 'dart:convert';

import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';

class TokenStore with InitializeOnStartup {

  TokenStore(this._secureStorage);

  Token _token;
  final SecureStorage _secureStorage;

  Future<void> onTokenFetched(Token token) {
    _token = token;
    return _secureStorage.storeToken(token);
  }

  bool hasValidToken() {
    return _token != null && _token.isValid();
  }

  @override
  Future<void> doInitialize() {
   return _secureStorage.readToken().then((String serializedToken){
     if (serializedToken != null) {
       _token = Token.fromJson(jsonDecode(serializedToken));
     }
   });
  }
}