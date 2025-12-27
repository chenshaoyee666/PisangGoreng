import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/app_drawer.dart';
import '../widgets/gradient_background.dart';
import 'food_upload_screen.dart';
import 'recipes_screen.dart';
import 'about_us_screen.dart';

class SharerDashboard extends StatefulWidget {
  const SharerDashboard({super.key});

  @override
  State<SharerDashboard> createState() => _SharerDashboardState();
}

class _SharerDashboardState extends State<SharerDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SmartBite'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ],
          ),
          drawer: const AppDrawer(),
          body: GradientBackground(child: _buildCurrentScreen(appState)),
          bottomNavigationBar: CustomBottomNavigation(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            isSharer: true,
          ),
        );
      },
    );
  }

  Widget _buildCurrentScreen(AppState appState) {
    switch (_currentIndex) {
      case 0:
        return _buildHomeScreen(appState);
      case 1:
        return const FoodUploadScreen();
      case 2:
        return _buildRecipesScreen();
      case 3:
        return _buildAboutScreen();
      default:
        return _buildHomeScreen(appState);
    }
  }

  Widget _buildHomeScreen(AppState appState) {
    final lang = appState.selectedLanguage;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Message at the top
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Welcome back, Sharer! Ready to make a difference today?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),

          Text(
            Translations.get('your_impact', lang),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.successGreen.withValues(alpha: 0.1),
                  AppTheme.primaryGreen.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildEnhancedStatCard(
                        '23',
                        Translations.get('items_shared', lang),
                        Icons.restaurant,
                        AppTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEnhancedStatCard(
                        '47',
                        Translations.get('people_helped', lang),
                        Icons.people,
                        AppTheme.accentOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildEnhancedStatCard(
                        'RM 340',
                        Translations.get('food_value', lang),
                        Icons.monetization_on,
                        AppTheme.successGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEnhancedStatCard(
                        '8.2 kg',
                        Translations.get('waste_saved', lang),
                        Icons.eco,
                        AppTheme.primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        Translations.get('weekly_impact', lang),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildChartBar('Mon', 0.3, AppTheme.primaryGreen),
                            _buildChartBar('Tue', 0.7, AppTheme.primaryGreen),
                            _buildChartBar('Wed', 0.5, AppTheme.primaryGreen),
                            _buildChartBar('Thu', 0.9, AppTheme.accentOrange),
                            _buildChartBar('Fri', 0.6, AppTheme.primaryGreen),
                            _buildChartBar('Sat', 0.4, AppTheme.primaryGreen),
                            _buildChartBar('Sun', 0.8, AppTheme.successGreen),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            Translations.get('quick_actions', lang),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  Translations.get('share_food', lang),
                  Translations.get('upload_share_food', lang),
                  Icons.camera_alt,
                  AppTheme.primaryGreen,
                  () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  Translations.get('find_recipes', lang),
                  Translations.get('discover_recipes', lang),
                  Icons.menu_book,
                  AppTheme.accentOrange,
                  () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            Translations.get('recent_shares', lang),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          _buildActivityCard(
            'Chicken Breast',
            'Delivered to Community Hub',
            '2 hours ago',
            AppTheme.successGreen,
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            'Mixed Vegetables',
            'Picked up by driver',
            '1 day ago',
            AppTheme.accentOrange,
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            'Bread Loaves (3x)',
            'Claimed by recipients',
            '2 days ago',
            AppTheme.successGreen,
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.accentOrange.withValues(alpha: 0.1),
                  AppTheme.primaryGreen.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: AppTheme.accentOrange,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'Community Hero!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accentOrange,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You\'ve shared over 20 items this month. Thank you for making a difference!',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // ...existing content...
          // Privacy Card at the bottom
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A237E), // dark blue
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.privacy_tip, color: const Color(0xFF64B5F6), size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your privacy is protected. Only you can see your claimed items.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: const Color(0xFF64B5F6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String status, String time, Color statusColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.fastfood, color: statusColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                  Text(status, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Text(time, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(String day, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: height * 60, // Max height 60
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipesScreen() {
    return const RecipesScreen();
  }

  Widget _buildAboutScreen() {
    return const AboutUsScreen();
  }
}