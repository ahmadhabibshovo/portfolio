class AppConfig {
  // Configurable base URL: can be passed via --dart-define=API_BASE_URL=...
  // or set dynamically via AppConfig.setBaseUrl(...)
  static String _baseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://portfolio-backend-xuzn.onrender.com/api/v1',
  );

  static String get baseUrl => _baseUrl;

  static void setBaseUrl(String url) {
    _baseUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }
}
