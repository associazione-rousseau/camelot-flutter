import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/storage/secure_storage.dart';

abstract class PushNotificationManager with InitializeOnStartup {
  Future<void> onLogin(String userId);

  Future<void> onLogout();
}

@injectable
class NoOpPushNotificationManager extends PushNotificationManager {
  @override
  Future<void> onLogin(String userId) {}

  @override
  Future<void> onLogout() {}

  @override
  Future<void> doInitialize() {}
}

@injectable
class FirebaseNotificationManager extends PushNotificationManager {

  FirebaseNotificationManager(this._firebaseMessaging, this._secureStorage);

  final FirebaseMessaging _firebaseMessaging;
  final SecureStorage _secureStorage;

  @override
  Future<void> onLogin(String userId) async {
    _initFirebase();
  }

  @override
  Future<void> onLogout() {
    _firebaseMessaging.deleteInstanceID();
    _unregisterToken();
  }

  @override
  Future<void> doInitialize() async {
    final Login login = getIt<Login>();
    if(login.isLoggedIn()) {
      _initFirebase();
    }
  }

  void _initFirebase() async {
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
        print('onResume: $message');
      },
    );
    _registerToken();
  }

  Future<void> _unregisterToken() async {
    final String lastRegisteredToken = await _getLastRegisteredToken();
    if (lastRegisteredToken != null) {
      // TODO graphql call
      print('Unregister Token: $lastRegisteredToken');
    }
  }

  Future<void> _registerToken() async {
    final String currentToken = await _firebaseMessaging.getToken();
    if (currentToken != null) {
      final String lastRegisteredToken = await _getLastRegisteredToken();
      if(lastRegisteredToken != currentToken) {
        // TODO graphql call
        print('Registering Token: $currentToken');
      }
    }
  }

  Future<String> _getLastRegisteredToken() async {
    return await _secureStorage.readFirebaseToken();
  }
}
