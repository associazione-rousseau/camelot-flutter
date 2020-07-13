
import 'dart:io';

import 'package:rousseau_vote/src/init/initialize_on_startup.dart';

class StartupInitializer with InitializeOnStartup {

  StartupInitializer(this._initializeOnStartup, this.minWaitMillisec);

  final List<InitializeOnStartup> _initializeOnStartup;
  final int minWaitMillisec;

  @override
  Future<void> doInitialize() async {
    final Stopwatch stopwatch = Stopwatch();
    stopwatch.start();

    for(InitializeOnStartup initializeOnStartup in _initializeOnStartup) {
      // TODO make it parallel. Not a concern now that there is only one element
      await initializeOnStartup.doInitialize();
    }

    stopwatch.stop();
    final int remainingTime = minWaitMillisec - stopwatch.elapsedMilliseconds;
    if (remainingTime > 0) {
      sleep(Duration(milliseconds: remainingTime));
    }
  }
}