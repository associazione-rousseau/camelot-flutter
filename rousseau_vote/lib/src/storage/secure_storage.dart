
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rousseau_vote/src/models/token.dart';

class SecureStorage {

  final String KEY_TOKEN = "key_token";

  final FlutterSecureStorage _flutterSecureStorage;

  SecureStorage(this._flutterSecureStorage);

  Future<void> storeToken(Token token) {
    return _flutterSecureStorage.write(key: KEY_TOKEN, value: jsonEncode(token));
  }

  Future<void>  readToken() {
    return _flutterSecureStorage.read(key: KEY_TOKEN);
  }
}