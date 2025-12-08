import 'package:flutter/foundation.dart';

enum UserRole { sharer, recipient }

class AppState extends ChangeNotifier {
  UserRole? _userRole;
  String _selectedLanguage = 'en';
  
  UserRole? get userRole => _userRole;
  String get selectedLanguage => _selectedLanguage;

  void setUserRole(UserRole role) {
    _userRole = role;
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  bool get isSharer => _userRole == UserRole.sharer;
  bool get isRecipient => _userRole == UserRole.recipient;
}