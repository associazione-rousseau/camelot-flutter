import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';

abstract class PushNotificationManager with InitializeOnStartup {
  Future<void> onLogin(String userId);

  Future<void> onLogout();
}

@injectable
class NoOpPushNotificationManager extends PushNotificationManager {
  @override
  Future<void> onLogin(String userId) async {}

  @override
  Future<void> onLogout() async {}

  @override
  Future<void> doInitialize() async {}
}

@injectable
class FirebaseNotificationManager extends PushNotificationManager {

  FirebaseNotificationManager(this._firebaseMessaging, this._secureStorage, this._graphQLClient);

  final FirebaseMessaging _firebaseMessaging;
  final SecureStorage _secureStorage;
  final GraphQLClient _graphQLClient;

  @override
  Future<void> onLogin(String userId) async {
    await _initFirebase();
  }

  @override
  Future<void> onLogout() async {
    await _firebaseMessaging.deleteInstanceID();
    await _unregisterToken();
  }

  @override
  Future<void> doInitialize() async {
    final Login login = getIt<Login>();
    if(login.isLoggedIn()) {
      await _initFirebase();
    }
  }

  Future<void> _initFirebase() async {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.setAutoInitEnabled(false);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        maybeOpenRoute(message);
      },
    );
    await _registerToken();
  }
  
  void maybeOpenRoute(Map<String, dynamic> message) {
    if(message.containsKey('data') && message['data']['route'] != null) {
      openRouteNoContext(message['data']['route'], replace: true);
    }
  }

  Future<void> _unregisterToken() async {
    final String lastRegisteredToken = await _getLastRegisteredToken();
    if (lastRegisteredToken != null) {
      final MutationOptions options = MutationOptions(documentNode: gql(tokenRemove), variables: <String, String>{ 'tokenString': lastRegisteredToken});
      final QueryResult result = await _graphQLClient.mutate(options);
      if (!result.hasException) {
        await _secureStorage.deleteFirebaseToken();
      }
    }
  }

  Future<void> _registerToken() async {
    final String currentToken = await _firebaseMessaging.getToken();
    if (currentToken != null) {
      final String lastRegisteredToken = await _getLastRegisteredToken();
      if(lastRegisteredToken != currentToken) {
        final Map<String, String> variables = <String, String>{ 'tokenString': currentToken, 'client': Platform.operatingSystem};
        final MutationOptions options = MutationOptions(documentNode: gql(tokenAdd), variables: variables);
        final QueryResult result = await _graphQLClient.mutate(options);
        if (!result.hasException) {
          await _secureStorage.storeFirebaseToken(currentToken);
        }
      }
    }
  }

  Future<String> _getLastRegisteredToken() async {
    return await _secureStorage.readFirebaseToken();
  }
}
