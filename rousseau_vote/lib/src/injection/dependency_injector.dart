import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectorio/injectorio.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/init/mock_initializer.dart';
import 'package:rousseau_vote/src/init/startup_initializer.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';
import 'package:rousseau_vote/src/store/token_store.dart';

class DependencyInjector {

  static void initInjector() {
    InjectorIO.start(mode: InjectorMode.PRODUCTION)
        .single<CookieJar>(_cookieJar())
        .single(_cookieManager())
        .single<DioForNative>(_dio())
        .single(_loginNetworkHandler())
        .single(_flutterSecureStorage())
        .single(_secureStorage())
        .single(_tokenStore())
        .single(_startupInitializer())
        .single(_login());
  }

  static Dio _dio() {
    final DioForNative dio = Dio();
    dio.interceptors.add(get<CookieManager>());
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

  static CookieManager _cookieManager() {
    return CookieManager(get<DefaultCookieJar>());
  }

  static CookieJar _cookieJar() {
    return CookieJar();
  }

  static Login _login() {
    return Login(get(), get());
  }

  static TokenStore _tokenStore() {
    return TokenStore(get());
  }

  static SecureStorage _secureStorage() {
    return SecureStorage(get());
  }

  static List<InitializeOnStartup> _needInitOnStartup() {
    return <InitializeOnStartup>[
      MockInitializer(1), // hack to show the splash screen for at least 3 seconds
      get<TokenStore>(),
    ];
  }

  static StartupInitializer _startupInitializer() {
    return StartupInitializer(_needInitOnStartup());
  }

  static FlutterSecureStorage _flutterSecureStorage() {
    return const FlutterSecureStorage();
  }

  static LoginNetworkHandler _loginNetworkHandler() {
    return LoginNetworkHandler(get<DioForNative>());
  }

}