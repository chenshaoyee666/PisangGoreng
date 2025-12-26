import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../screens/welcome_screen.dart';
import '../screens/about_us_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final lang = appState.selectedLanguage;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen,
                      AppTheme.primaryGreen.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.eco,
                          size: 30,
                          color: Colors.white,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'SmartBite',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '${Translations.get('current_role', lang)}: ${appState.isSharer ? Translations.get('sharer', lang) : Translations.get('recipient', lang)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(Translations.get('home', lang)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: Text(Translations.get('switch_role', lang)),
                onTap: () {
                  Navigator.pop(context);
                  _showRoleSwitchDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(Translations.get('language', lang)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLanguageButton('🇬🇧', 'en', appState),
                    const SizedBox(width: 4),
                    _buildLanguageButton('🇨🇳', 'zh', appState),
                    const SizedBox(width: 4),
                    _buildLanguageButton('🇲🇾', 'ms', appState),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(Translations.get('settings', lang)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings feature coming soon!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(Translations.get('about', lang)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: AppTheme.warningRed),
                title: Text(Translations.get('back_to_welcome', lang), style: const TextStyle(color: AppTheme.warningRed)),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToWelcome(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton(String flag, String code, AppState appState) {
    final isSelected = appState.selectedLanguage == code;
    return GestureDetector(
      onTap: () => appState.setLanguage(code),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGreen.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: isSelected ? Border.all(color: AppTheme.primaryGreen, width: 1) : null,
        ),
        child: Text(flag, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  void _showRoleSwitchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Switch Role'),
        content: const Text('Would you like to switch between Sharer and Recipient roles?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToWelcome(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
            ),
            child: const Text('Switch Role'),
          ),
        ],
      ),
    );
  }

  void _navigateToWelcome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }
}