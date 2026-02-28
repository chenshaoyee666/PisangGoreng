import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/app_drawer.dart';
import 'about_us_screen.dart';
import 'food_upload_screen.dart';
import 'recipes_screen.dart';
import 'login_screen.dart';

class SharerDashboard extends StatefulWidget {
  const SharerDashboard({super.key});

  @override
  State<SharerDashboard> createState() => _SharerDashboardState();
}

class _SharerDashboardState extends State<SharerDashboard> {
      Widget _buildActivityCard({
        required String title,
        required String status,
        required String time,
        required Color statusColor,
      }) {
        return Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor == AppTheme.successGreen || statusColor == AppTheme.primaryGreen
                        ? Color(0xFF1A237E).withAlpha((0.08 * 255).toInt())
                        : statusColor.withAlpha((0.08 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.fastfood,
                    color: statusColor == AppTheme.successGreen || statusColor == AppTheme.primaryGreen
                        ? Color(0xFF1A237E)
                        : statusColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                      Text(status, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins')),
                    ],
                  ),
                ),
                Text(time, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins')),
              ],
            ),
          ),
        );
      }

      Widget _buildEnhancedStatCard({
        required String value,
        required String label,
        required IconData icon,
        required Color color,
      }) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
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
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      Widget _buildChartBar({
        required String day,
        required double height,
        required Color color,
      }) {
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, fontFamily: 'Poppins'),
            ),
          ],
        );
      }

      Widget _buildCurrentScreen(AppState appState) {

        final lang = appState.selectedLanguage;
        switch (_currentIndex) {
          case 0:
            return _buildHomeScreen(context, lang);
          case 1:
            return const FoodUploadScreen();
          case 2:
            return const RecipesScreen();
          case 3:
            return const AboutUsScreen();
          default:
            return _buildHomeScreen(context, lang);
        }
      }
    Widget _buildHomeScreen(BuildContext context, String lang) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                color: Color(0xFFFFF6D6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Sharer !',
                    style: TextStyle(
                      color: Color(0xFF4E342E), // dark brown
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ready to make a difference today?',
                    style: TextStyle(
                      color: Color(0xFF4E342E), // dark brown
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              Translations.get('your_impact', lang),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E), // dark brown
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.successGreen.withAlpha((0.1 * 255).toInt()),
                    AppTheme.primaryGreen.withAlpha((0.05 * 255).toInt()),
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
                          value: '23',
                          label: Translations.get('items_shared', lang),
                          icon: Icons.restaurant,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildEnhancedStatCard(
                          value: '47',
                          label: Translations.get('people_helped', lang),
                          icon: Icons.people,
                          color: Color(0xFFDA650B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildEnhancedStatCard(
                          value: 'RM 340',
                          label: Translations.get('food_value', lang),
                          icon: Icons.monetization_on,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildEnhancedStatCard(
                          value: '8.2 kg',
                          label: Translations.get('waste_saved', lang),
                          icon: Icons.eco,
                          color: Color(0xFF1A237E),
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
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildChartBar(day: 'Mon', height: 0.3, color: Color(0xFF1A237E)),
                              _buildChartBar(day: 'Tue', height: 0.7, color: Color(0xFF1A237E)),
                              _buildChartBar(day: 'Wed', height: 0.5, color: Color(0xFF1A237E)),
                              _buildChartBar(day: 'Thu', height: 0.9, color: Color(0xFFDA650B)),
                              _buildChartBar(day: 'Fri', height: 0.6, color: Color(0xFF1A237E)),
                              _buildChartBar(day: 'Sat', height: 0.4, color: Color(0xFF1A237E)),
                              _buildChartBar(day: 'Sun', height: 0.8, color: Color(0xFF1A237E)),
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
                color: Color(0xFF4E342E), // dark brown
                fontFamily: 'Poppins',
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
                    Color(0xFF1A237E), // dark blue
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600, // SemiBold
                color: Color(0xFF4E342E), // dark brown
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            _buildActivityCard(
              title: 'Chicken Breast',
              status: 'Delivered to Community Hub',
              time: '2 hours ago',
              statusColor: AppTheme.successGreen,
            ),
            const SizedBox(height: 12),
            _buildActivityCard(
              title: 'Mixed Vegetables',
              status: 'Picked up by driver',
              time: '1 day ago',
              statusColor: AppTheme.accentOrange,
            ),
            const SizedBox(height: 12),
            _buildActivityCard(
              title: 'Bread Loaves (3x)',
              status: 'Claimed by recipients',
              time: '2 days ago',
              statusColor: AppTheme.successGreen,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFDA650B).withAlpha((0.1 * 255).toInt()),
                    AppTheme.primaryGreen.withAlpha((0.1 * 255).toInt()),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFDA650B),
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Community Hero!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDA650B),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ve shared over 20 items this month. Thank you for making a difference!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.privacy_tip, color: Color(0xFF4E342E), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your privacy is protected. Only you can see your claimed items.',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Color(0xFF4E342E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  int _currentIndex = 0;

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color welcomeBg = Color(0xFFFFF9EC);
    return Scaffold(
      backgroundColor: welcomeBg,
      appBar: AppBar(
        backgroundColor: welcomeBg,
        elevation: 0,
        title: const Text('SmartBite', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [

          SizedBox(
            width: double.infinity,
            height: 220,
            child: CustomPaint(
              painter: _DashboardBubblesPainter(),
            ),
          ),
          Consumer<AppState>(
            builder: (context, appState, child) {
              return _buildCurrentScreen(appState);
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        isSharer: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _DashboardBubblesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bubblePaint = Paint()..color = const Color(0xFFFFCC80).withOpacity(0.7);
    final bubblePaint2 = Paint()..color = const Color(0xFFDA650B).withOpacity(0.18);
    final bubblePaint3 = Paint()..color = const Color(0xFF1A237E).withOpacity(0.10);

    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.32), 32, bubblePaint);
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.18), 22, bubblePaint2);
    canvas.drawCircle(Offset(size.width * 0.60, size.height * 0.55), 18, bubblePaint3);
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.12), 14, bubblePaint2);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.38), 12, bubblePaint);

    canvas.drawCircle(Offset(size.width * 0.15, size.height * 1.60), 28, bubblePaint2); // left
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 2.33), 36, bubblePaint); // center (further off canvas for effect)
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 1.48), 20, bubblePaint3); // right

    final path = Path();
    path.moveTo(0, size.height * 0.85);
    path.cubicTo(
      size.width * 0.20, size.height * 0.80,
      size.width * 0.40, size.height * 0.95,
      size.width * 0.60, size.height * 0.80,
    );
    path.cubicTo(
      size.width * 0.80, size.height * 0.65,
      size.width * 0.90, size.height * 0.95,
      size.width, size.height * 0.85,
    );
    final linePaint = Paint()
      ..color = const Color(0xFFDA650B).withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}