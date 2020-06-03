// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:rousseau_vote/src/network/handlers/blog_instant_article_network_handler.dart';
import 'package:rousseau_vote/src/providers/blog_instant_article_provider.dart';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/injection/register_module.dart';
import 'package:rousseau_vote/src/providers/external_preselection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql/client.dart';
import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';
import 'package:rousseau_vote/src/network/graphql/smart_cache.dart';
import 'package:rousseau_vote/src/init/startup_initializer.dart';
import 'package:rousseau_vote/src/store/token_store.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();
  g.registerFactoryParam<GraphQLClient, BuildContext, dynamic>(
      (buildContext, _) => registerModule.getGraphQLClient(buildContext));
  g.registerFactory<StartupInitializer>(
      () => registerModule.startupInitializer);
  g.registerFactoryParam<ValueNotifier<GraphQLClient>, BuildContext, dynamic>(
      (buildContext, _) =>
          registerModule.getGraphqlClientNotifier(buildContext));

  //Eager singletons must be registered in the right order
  g.registerSingleton<BlogInstantArticleNetworkHandler>(
      BlogInstantArticleNetworkHandler());
  g.registerSingleton<BlogInstantArticleProvider>(
      BlogInstantArticleProvider(g<BlogInstantArticleNetworkHandler>()));
  g.registerSingleton<Dio>(registerModule.dioForNative());
  g.registerSingletonAsync<ExternalPreselection>(
      () => ExternalPreselection.create());
  g.registerSingleton<FlutterSecureStorage>(
      registerModule.flutterSecureStorage);
  g.registerSingleton<LoginNetworkHandler>(LoginNetworkHandler(g<Dio>()));
  g.registerSingleton<SecureStorage>(SecureStorage(g<FlutterSecureStorage>()));
  g.registerSingleton<SmartCache>(registerModule.smartCache);
  g.registerSingleton<TokenStore>(
      TokenStore(g<SecureStorage>(), g<LoginNetworkHandler>()));
  g.registerSingleton<Login>(Login(g<LoginNetworkHandler>(), g<TokenStore>()));
}

class _$RegisterModule extends RegisterModule {
  @override
  FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();
}
