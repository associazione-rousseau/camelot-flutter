
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';

class StartupInitializer with InitializeOnStartup {

  StartupInitializer(this._initializeOnStartup);

  final List<InitializeOnStartup> _initializeOnStartup;

  @override
  Future<void> doInitialize() async {
    for(InitializeOnStartup initializeOnStartup in _initializeOnStartup) {
      // TODO make it parallel. Not a concern now that there is only one element
      await initializeOnStartup.doInitialize();
    }
  }
}