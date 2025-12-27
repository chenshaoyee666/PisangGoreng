import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../widgets/gradient_background.dart';
import 'sharer_dashboard.dart';
import 'recipient_dashboard.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final lang = appState.selectedLanguage;
        
        return Scaffold(
          body: GradientBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Language Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildLanguageToggle(context),
                      ],
                    ),
                    
                    const SizedBox(height: 0),
                    
                    Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(110),
                            ),
                            child: const Icon(
                              Icons.eco,
                              size: 100,
                              color: AppTheme.primaryGreen,
                            ),
                          );
                        },
                      ),
                      Transform.translate(
                        offset: const Offset(0, -55),
                        child: Text(
                          Translations.get('app_name', lang),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF5D4037),
                            fontWeight: FontWeight.w700,
                            fontSize: 50,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -50),
                        child: Text(
                          Translations.get('tagline', lang),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 0),
                  
                  Text(
                    Translations.get('how_to_help', lang),
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5D4037),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  _buildRoleCard(
                    context,
                    title: Translations.get('continue_sharer', lang),
                    subtitle: Translations.get('sharer_subtitle', lang),
                    imagePath: 'assets/images/sharer.png',
                    color: const Color(0xFF00296B),
                    onTap: () => _selectRole(context, UserRole.sharer),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  _buildRoleCard(
                    context,
                    title: Translations.get('continue_recipient', lang),
                    subtitle: Translations.get('recipient_subtitle', lang),
                    imagePath: 'assets/images/receipient.png',
                    color: const Color(0xFFDA6508),
                    onTap: () => _selectRole(context, UserRole.recipient),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    Translations.get('together_message', lang),
                    style: GoogleFonts.libreBaskerville(
                      color: const Color(0xFF5D4037),
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageToggle(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageButton('🇬🇧', 'en', appState.selectedLanguage, appState),
            const SizedBox(width: 8),
            _buildLanguageButton('🇨🇳', 'zh', appState.selectedLanguage, appState),
            const SizedBox(width: 8),
            _buildLanguageButton('🇲🇾', 'ms', appState.selectedLanguage, appState),
          ],
        );
      },
    );
  }

  Widget _buildLanguageButton(String flag, String code, String selected, AppState appState) {
    final isSelected = selected == code;
    
    // Use text labels for better web compatibility
    final Map<String, String> labels = {
      'en': 'EN',
      'zh': '中文',
      'ms': 'BM',
    };
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          debugPrint('Language button tapped: $code');
          appState.setLanguage(code);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5D4037).withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF5D4037) : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            labels[code] ?? code.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFF5D4037) : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imagePath,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectRole(BuildContext context, UserRole role) {
    context.read<AppState>().setUserRole(role);
    
    Widget destination;
    if (role == UserRole.sharer) {
      destination = const SharerDashboard();
    } else {
      destination = const RecipientDashboard();
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}