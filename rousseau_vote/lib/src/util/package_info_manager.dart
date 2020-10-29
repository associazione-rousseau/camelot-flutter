
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:rousseau_vote/src/init/initialize_on_startup.dart';

@singleton
class PackageInfoManager with InitializeOnStartup {

  PackageInfo packageInfo;

  @override
  Future<void> doInitialize() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
