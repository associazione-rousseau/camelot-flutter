
import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';
import 'package:sentry/sentry.dart';

@injectable
class ErrorLogger {

  const ErrorLogger(this._sentryClient);

  final SentryClient _sentryClient;

  bool isEnabled() {
    return _sentryClient != null;
  }

  void reportError(dynamic error, StackTrace stackTrace) {
    if (isInDebugMode || _sentryClient == null) {
      print(stackTrace);
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      _sentryClient.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool get isInDebugMode {
    // Assume you're in production mode.
    bool inDebugMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDebugMode = true);

    return inDebugMode;
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