/// API Configuration for SmartBite App
///
/// Change this to your computer's IP address when testing on a physical device
/// For emulator/web: use 'localhost' or '10.0.2.2' (Android emulator)
/// For physical device: use your computer's IP address (e.g., '192.168.0.142')

class ApiConfig {
  /// Base URL for the Python backend.
  ///
  /// Default (Chrome/web on same machine): http://localhost:5000
  /// Override at runtime via:
  ///   flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:5000
  /// Android emulator usually uses:
  ///   http://10.0.2.2:5000
  /// Physical device: use your computer's LAN IP:
  ///   http://192.168.x.x:5000
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000',
  );

  // API Endpoints
  static const String recipeEndpoint = '/api/recipe/suggest';
  static const String chatEndpoint = '/api/recipe/chat';
  static const String healthEndpoint = '/health';

  static String get recipeUrl => '$baseUrl$recipeEndpoint';
  static String get chatUrl => '$baseUrl$chatEndpoint';
  static String get healthUrl => '$baseUrl$healthEndpoint';
}
