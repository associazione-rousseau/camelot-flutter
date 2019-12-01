
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';

// it just wait n seconds. Useful to show the splash screen
class MockInitializer with InitializeOnStartup {
  MockInitializer(this._waitSeconds);

  final int _waitSeconds;

  @override
  Future<void> doInitialize() {
    return Future<void>.delayed(Duration(seconds: _waitSeconds));
  }

}