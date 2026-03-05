import '../config/app_config.dart';

/// Logger com nível por ambiente.
/// - DEBUG  → só em dev
/// - INFO/WARN → dev e staging
/// - ERROR → todos os ambientes (prod deve redirecionar para crash reporter)
abstract final class AppLogger {
  static void d(String message, {Object? error, StackTrace? stackTrace}) {
    if (AppConfig.isDev) _log('DEBUG', message, error, stackTrace);
  }

  static void i(String message, {Object? error, StackTrace? stackTrace}) {
    if (!AppConfig.isProd) _log('INFO ', message, error, stackTrace);
  }

  static void w(String message, {Object? error, StackTrace? stackTrace}) {
    if (!AppConfig.isProd) _log('WARN ', message, error, stackTrace);
  }

  static void e(String message, {Object? error, StackTrace? stackTrace}) {
    _log('ERROR', message, error, stackTrace);
    // TODO(prod): encaminhar para Sentry / Firebase Crashlytics em prod
  }

  static void _log(
    String level,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    final buffer = StringBuffer('[${AppConfig.flavor.toUpperCase()}][$level] $message');
    if (error != null) buffer.write('\n  Error: $error');
    if (stackTrace != null) buffer.write('\n$stackTrace');
    // ignore: avoid_print
    print(buffer.toString());
  }
}
