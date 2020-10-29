import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/util/debug_util.dart';
import 'package:rousseau_vote/src/util/package_info_manager.dart';
import 'package:sentry/sentry.dart';

@injectable
class ErrorLogger {
  const ErrorLogger(this._sentryClient);

  final SentryClient _sentryClient;

  bool isEnabled() {
    return !isInDebugMode && _sentryClient != null;
  }

  void reportError(dynamic error, StackTrace stackTrace) {
    if (!isEnabled()) {
      print(stackTrace);
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      final CurrentUser currentUser = getIt<UserNetworkHandler>().currentUser;
      _sentryClient.userContext =
          currentUser != null ? User(id: currentUser.id) : null;
      _sentryClient.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  @factoryMethod
  static Future<ErrorLogger> create() async {
    try {
      final String sentryDsn =
          await rootBundle.loadString('assets/secrets/sentry-dsn.txt');
      if (sentryDsn != null && sentryDsn.startsWith('http')) {
        final PackageInfo packageInfo =
            await getIt<PackageInfoManager>().loadPackageInfo();
        return ErrorLogger(SentryClient(
            dsn: sentryDsn,
            environmentAttributes: Event(
                release: packageInfo?.version,
                tags: <String, String>{'platform': Platform.operatingSystem})));
      }
    } catch (_) {}

    return const ErrorLogger(null);
  }
}
