/// API Configuration for SmartBite App
/// 
/// Change this to your computer's IP address when testing on a physical device
/// For emulator/web: use 'localhost' or '10.0.2.2' (Android emulator)
/// For physical device: use your computer's IP address (e.g., '192.168.0.142')

class ApiConfig {
  // Change this to your computer's IP address for mobile testing
  static const String baseUrl = 'http://192.168.0.142:5000';
  
  // For web/emulator testing, use:
  // static const String baseUrl = 'http://localhost:5000';
  
  // API Endpoints
  static const String recipeEndpoint = '/api/recipe/suggest';
  static const String chatEndpoint = '/api/recipe/chat';
  static const String healthEndpoint = '/health';
  
  static String get recipeUrl => '$baseUrl$recipeEndpoint';
  static String get chatUrl => '$baseUrl$chatEndpoint';
  static String get healthUrl => '$baseUrl$healthEndpoint';
}
