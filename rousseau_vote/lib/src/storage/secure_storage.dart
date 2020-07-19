
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/token.dart';

@singleton
class SecureStorage {

  SecureStorage(this._flutterSecureStorage);

  static const String _KEY_TOKEN = 'key_token';
  static const String _KEY_FIREBASE_TOKEN = 'key_token';

  final FlutterSecureStorage _flutterSecureStorage;

  Future<void> deleteToken() {
    return _flutterSecureStorage.delete(key: _KEY_TOKEN);
  }

  Future<void> storeToken(Token token) {
    return _flutterSecureStorage.write(key: _KEY_TOKEN, value: jsonEncode(token));
  }

  Future<String>  readToken() {
    return _flutterSecureStorage.read(key: _KEY_TOKEN);
  }

  Future<void> deleteFirebaseToken() {
    return _flutterSecureStorage.delete(key: _KEY_FIREBASE_TOKEN);
  }

  Future<void> storeFirebaseToken(String token) {
    return _flutterSecureStorage.write(key: _KEY_FIREBASE_TOKEN, value: token);
  }

  Future<String>  readFirebaseToken() {
    return _flutterSecureStorage.read(key: _KEY_FIREBASE_TOKEN);
  }
}