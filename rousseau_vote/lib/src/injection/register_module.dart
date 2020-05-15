import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/mock_initializer.dart';
import 'package:rousseau_vote/src/init/startup_initializer.dart';
import 'package:rousseau_vote/src/store/token_store.dart';

import 'injector_config.dart';

@registerModule
abstract class RegisterModule {

  @singleton
  FlutterSecureStorage get flutterSecureStorage;

  // all the initializer here are going to be executed at startup time
  StartupInitializer get startupInitializer => StartupInitializer([
    MockInitializer(1), // hack used to show the splash screen, remove when you have real waiting time on startup
    getIt<TokenStore>()
  ]);

  @singleton
  @RegisterAs(Dio)
  DioForNative dioForNative() {
    final DioForNative dio = DioForNative();
    final CookieManager cookieManager = CookieManager(DefaultCookieJar());
    dio.interceptors.add(cookieManager);
    dio.interceptors.add(InterceptorsWrapper(
      // ignore: always_specify_types
        onResponse: (Response response) {
          if (response.data != null && response.data is String) {
            final Map<String, dynamic> decodedData = jsonDecode(response.data);
            response.data = decodedData;
          }
          return response;
        }
    ));
    return dio;
  }
}