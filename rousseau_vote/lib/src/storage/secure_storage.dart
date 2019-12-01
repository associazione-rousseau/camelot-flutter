
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rousseau_vote/src/models/token.dart';

class SecureStorage {

  SecureStorage(this._flutterSecureStorage);

  static const String _KEY_TOKEN = 'key_token';

  final FlutterSecureStorage _flutterSecureStorage;

  Future<void> storeToken(Token token) {
    return _flutterSecureStorage.write(key: _KEY_TOKEN, value: jsonEncode(token));
  }

  Future<String>  readToken() {
    return _flutterSecureStorage.read(key: _KEY_TOKEN);
  }
}