import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../screens/welcome_screen.dart';
import '../screens/about_us_screen.dart';
class AppDrawer extends StatelessWidget {
    void _showRoleSwitchDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Switch Role'),
          content: Text('Would you like to switch between Sharer and Recipient roles?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToWelcome(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
              ),
              child: Text('Switch Role'),
            ),
          ],
        ),
      );
    }
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
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF9EC),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),

                    Text(
                      'SmartBite',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF5D4037),
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${Translations.get('current_role', lang)}: ${appState.isSharer ? Translations.get('sharer', lang) : Translations.get('recipient', lang)}',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF5D4037),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(Translations.get('home', lang), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.swap_horiz),
                title: Text(Translations.get('switch_role', lang), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                  _showRoleSwitchDialog(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(Translations.get('language', lang), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLanguageButton('🇬🇧', 'en', appState),
                    SizedBox(width: 4),
                    _buildLanguageButton('🇨🇳', 'zh', appState),
                    SizedBox(width: 4),
                    _buildLanguageButton('🇲🇾', 'ms', appState),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(Translations.get('settings', lang), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Settings feature coming soon!')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text(Translations.get('about', lang), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Color(0xFFFF0000)),
                title: Text(Translations.get('back_to_welcome', lang), style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Color(0xFFFF0000))),
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
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGreen.withAlpha((0.1 * 255).toInt()) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: isSelected ? Border.all(color: AppTheme.primaryGreen, width: 1) : null,
        ),
        child: Text(flag, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  void _navigateToWelcome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (route) => false,
    );
  }
}
