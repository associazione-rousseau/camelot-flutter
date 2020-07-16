
import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/util/debug_util.dart';
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
      _sentryClient.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  @factoryMethod
  static Future<ErrorLogger> create() async {
    try {
      final String sentryDsn = await rootBundle.loadString('assets/secrets/sentry-dsn.txt');
      if (sentryDsn != null && sentryDsn.startsWith('http')) {
        return ErrorLogger(SentryClient(dsn: sentryDsn));
      }
    } catch (_) {}

    return const ErrorLogger(null);
  }
}