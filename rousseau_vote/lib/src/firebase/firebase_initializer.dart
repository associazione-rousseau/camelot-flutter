
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';

@singleton
class FirebaseInitializer with InitializeOnStartup {
  @override
  Future<void> doInitialize() async {
    await Firebase.initializeApp();
  }
}
