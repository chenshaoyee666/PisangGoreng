import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isSharer;

  final Color? backgroundColor;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isSharer,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final lang = appState.selectedLanguage;
        List<BottomNavigationBarItem> items = isSharer
            ? _getSharerItems(lang)
            : _getRecipientItems(lang);

        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF4E342E), // Dark brown
          unselectedItemColor: AppTheme.textSecondary,
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: 8,
          items: items,
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getSharerItems(String lang) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: Translations.get('home', lang),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.camera_alt),
        label: Translations.get('upload', lang),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.menu_book),
        label: Translations.get('recipes', lang),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.info_outline),
        label: Translations.get('about', lang),
      ),
    ];
  }

  List<BottomNavigationBarItem> _getRecipientItems(String lang) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: Translations.get('home', lang),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.qr_code_scanner),
        label: Translations.get('scan_qr', lang),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.map),
        label: Translations.get('map', lang),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.info_outline),
        label: Translations.get('about', lang),
      ),
    ];
  }
}