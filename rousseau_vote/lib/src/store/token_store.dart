
import 'package:rousseau_vote/src/models/token.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';

class TokenStore {
  Token token;
  final SecureStorage _secureStorage;

  TokenStore(this._secureStorage) {
    this._secureStorage.readToken();
  }

  Future<void> onTokenFetched(Token token) {
    this.token = token;
    return this._secureStorage.storeToken(token);
  }

  bool hasValidToken() {
    return token != null && token.isValid();
  }
}