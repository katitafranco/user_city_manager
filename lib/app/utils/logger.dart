/// Custom logger for the application with different log levels
class AppLogger {
  static const bool _enableLogging = true; // Set to false in production
  
  /// Log debug messages (development only)
  static void debug(String message, {String tag = 'DEBUG'}) {
    if (_enableLogging) {
      // Use debugPrint for Flutter to avoid truncation
      // ignore: avoid_print
      print('🐛 [$tag]: $message');
    }
  }
  
  /// Log informational messages
  static void info(String message, {String tag = 'INFO'}) {
    if (_enableLogging) {
      // ignore: avoid_print
      print('ℹ️ [$tag]: $message');
    }
  }
  
  /// Log warning messages
  static void warning(String message, {String tag = 'WARNING'}) {
    if (_enableLogging) {
      // ignore: avoid_print
      print('⚠️ [$tag]: $message');
    }
  }
  
  /// Log error messages (always shown)
  static void error(String message, {String tag = 'ERROR', Object? error, StackTrace? stackTrace}) {
    // Errors should always be logged, even in production
    // ignore: avoid_print
    print('❌ [$tag]: $message');
    if (error != null) {
      // ignore: avoid_print
      print('Error details: $error');
    }
    if (stackTrace != null) {
      // ignore: avoid_print
      print('Stack trace: $stackTrace');
    }
  }
  
  /// Log network requests
  static void networkRequest(String method, String url, {dynamic data}) {
    if (_enableLogging) {
      // ignore: avoid_print
      print('🌐 [NETWORK REQUEST]: $method $url');
      if (data != null) {
        // ignore: avoid_print
        print('📦 Request Body: $data');
      }
    }
  }
  
  /// Log network responses
  static void networkResponse(int statusCode, String url, {dynamic data}) {
    if (_enableLogging) {
      final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
      // ignore: avoid_print
      print('$emoji [NETWORK RESPONSE]: $statusCode $url');
      if (data != null) {
        // ignore: avoid_print
        print('📦 Response Data: $data');
      }
    }
  }
  
  /// Log network errors
  static void networkError(String url, int? statusCode, String error) {
    // Network errors should always be logged
    // ignore: avoid_print
    print('🚨 [NETWORK ERROR]: $statusCode $url');
    // ignore: avoid_print
    print('Error: $error');
  }
}