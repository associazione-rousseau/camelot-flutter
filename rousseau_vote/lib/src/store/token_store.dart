
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';

class TokenStore {

  TokenStore(this._secureStorage) {
    _secureStorage.readToken();
  }

  Token token;
  final SecureStorage _secureStorage;

  Future<void> onTokenFetched(Token token) {
    this.token = token;
    return _secureStorage.storeToken(token);
  }

  bool hasValidToken() {
    return token != null && token.isValid();
  }
}