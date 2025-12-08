import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../screens/welcome_screen.dart';
import '../screens/about_us_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
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
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.eco,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
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
                      'Current role: ${appState.isSharer ? 'Sharer' : 'Recipient'}',
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
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Switch Role'),
                onTap: () {
                  Navigator.pop(context);
                  _showRoleSwitchDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
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
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings feature coming soon!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
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
                title: const Text('Back to Welcome', style: TextStyle(color: AppTheme.warningRed)),
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