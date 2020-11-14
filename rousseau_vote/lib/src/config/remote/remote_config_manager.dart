
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';

@singleton
class RemoteConfigManager with InitializeOnStartup {

  RemoteConfig _remoteConfig;

  @override
  Future<void> doInitialize() async {
    _remoteConfig = await RemoteConfig.instance;

    await _remoteConfig.fetch(expiration: const Duration(hours: 5));
    await _remoteConfig.activateFetched();
  }

  String getString(String key) => _remoteConfig.getString(key);

  bool getBool(String key) => _remoteConfig.getBool(key);

  double getDouble(String key) => _remoteConfig.getDouble(key);

  int getInt(String key) => _remoteConfig.getInt(key);
}
