class AppConfig {
  static const String baseUrl = 'https://caseapi.servicelabs.tech';

  // Endpointler
  static const String loginEndpoint = '/user/login';
  static const String registerEndpoint = '/user/register';

  static const Map<String, String> jsonHeaders = {
    'Content-Type': 'application/json',
  };

  static const Duration requestTimeout = Duration(seconds: 30);
}
