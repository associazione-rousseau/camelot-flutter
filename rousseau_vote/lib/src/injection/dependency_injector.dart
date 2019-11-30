import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectorio/injectorio.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';
import 'package:rousseau_vote/src/store/token_store.dart';

class DependencyInjector {
  static initInjector() {
    InjectorIO.start(mode: InjectorMode.PRODUCTION)
        .single<CookieJar>(_cookieJar())
        .single(_cookieManager())
        .single<DioForNative>(_dio())
        .single(_loginNetworkHandler())
        .single(_flutterSecureStorage())
        .single(_secureStorage())
        .single(_tokenStore())
        .single(_login());
  }

  static Dio _dio() {
    final dio = Dio();
    dio.interceptors.add(get<CookieManager>());
    dio.interceptors.add(InterceptorsWrapper(
        onResponse:(Response response) async {
          if (response.data != null && response.data is String) {
            Map<String, dynamic> decodedData = jsonDecode(response.data);
            response.data = decodedData;
          }
          return response;
        }
    ));
    return dio as DioForNative;
  }

  static CookieManager _cookieManager() {
    return CookieManager(get<DefaultCookieJar>());
  }

  static CookieJar _cookieJar() {
    return CookieJar();
  }

  static _login() {
    return Login(get(), get());
  }

  static _tokenStore() {
    return TokenStore(get());
  }

  static _secureStorage() {
    return SecureStorage(get());
  }

  static _flutterSecureStorage() {
    return FlutterSecureStorage();
  }

  static _loginNetworkHandler() {
    return LoginNetworkHandler(get<DioForNative>());
  }

}