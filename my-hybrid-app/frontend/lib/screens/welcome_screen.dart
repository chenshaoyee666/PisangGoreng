import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/translations.dart';
import '../widgets/card_half_circle_decoration.dart';
import '../widgets/background_bubbles.dart';
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
          backgroundColor: const Color(0xFFFFF9EC),
          body: SafeArea(
            child: Stack(
              children: [

                BackgroundBubbles(
                  bubbles: [
                    BubbleData(top: 40, left: 20, size: 120, color: Color(0xFFFFF6E5)),
                    BubbleData(bottom: 80, right: 30, size: 80, color: Color(0xFFBCA17A)),
                    BubbleData(top: 200, right: -40, size: 100, color: Color(0xFFFFEE8C)),
                    BubbleData(bottom: -30, left: -30, size: 90, color: Color(0xFFF8F4FF)),

                    BubbleData(top: 120, left: -40, size: 70, color: Color(0xFFFFEE8C)),
                    BubbleData(bottom: 200, left: 10, size: 60, color: Color(0xFFBCA17A)),
                    BubbleData(top: 320, left: -30, size: 50, color: Color(0xFFF8F4FF)),
                    BubbleData(bottom: 350, left: 30, size: 40, color: Color(0xFFFFF6E5)),
                    BubbleData(top: 500, left: 0, size: 80, color: Color(0xFFFFEE8C)),

                    BubbleData(top: 60, left: 60, size: 36, color: Color(0xFFFFEE8C)),
                    BubbleData(top: 90, left: 100, size: 22, color: Color(0xFFBCA17A)),
                  ],
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),

                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 16, left: 16), // add right and left padding for spacing
                              child: _buildLanguageToggle(context),
                            ),
                          ),

                          Column(
                            children: [
                              const SizedBox(height: 32),
                              Center(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  Translations.get('app_name', lang),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40,
                                    color: Color(0xFF5D4037),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          Translations.get('tagline', lang),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Color(0xFFBCA17A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          Translations.get('how_to_help', lang),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFF2D2D2D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          color: Color(0xFFF8F4FF),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [

                              const Positioned(
                                top: 0,
                                right: 0,
                                child: CardHalfCircleDecoration(
                                  size: 80,
                                  alignment: Alignment.topRight,
                                  color: Color(0xFFFFF6E5),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => _selectRole(context, UserRole.sharer),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/sharer.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Translations.get('continue_sharer', lang),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color(0xFF2D2D2D),
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              Translations.get('sharer_subtitle', lang),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color(0xFF7A7A7A),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right, color: Color(0xFFBCA17A)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          color: Color(0xFFF8F4FF),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [

                              const Positioned(
                                top: 0,
                                right: 0,
                                child: CardHalfCircleDecoration(
                                  size: 80,
                                  alignment: Alignment.topRight,
                                  color: Color(0xFFFFF6E5),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => _selectRole(context, UserRole.recipient),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/receipient.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Translations.get('continue_recipient', lang),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color(0xFF2D2D2D),
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              Translations.get('recipient_subtitle', lang),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color(0xFF7A7A7A),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right, color: Color(0xFFBCA17A)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            Translations.get('together_message', lang),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF7A7A7A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          '💛',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageToggle(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final selected = appState.selectedLanguage;
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4), // Add small left and right padding to the row
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguagePill('EN', 'en', selected, appState),
                const SizedBox(width: 10),
                _buildLanguagePill('中文', 'zh', selected, appState),
                const SizedBox(width: 10),
                _buildLanguagePill('BM', 'ms', selected, appState),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguagePill(String label, String code, String selected, AppState appState) {
    final bool isSelected = selected == code;
    return GestureDetector(
      onTap: () => appState.setLanguage(code),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEE8C) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFEE8C) : const Color(0xFFD6CBA4),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFFEE8C).withValues(alpha: (0.2 * 255)),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5D4037),
            fontWeight: FontWeight.w600,
            fontSize: 13,
            fontFamily: 'Poppins',
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