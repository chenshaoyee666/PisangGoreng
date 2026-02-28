import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../widgets/gradient_background.dart';
import '../widgets/background_bubbles.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/fake_map_widget.dart';
import '../widgets/app_drawer.dart';
import 'about_us_screen.dart';
import 'qr_scanner_screen.dart';
import 'login_screen.dart';

class RecipientDashboard extends StatefulWidget {
  const RecipientDashboard({super.key});

  @override
  State<RecipientDashboard> createState() => _RecipientDashboardState();
}

class _RecipientDashboardState extends State<RecipientDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    const Color welcomeBg = Color(0xFFFFF9EC);
    final screens = [
      _buildHomeScreen(appState),
      const QRScannerScreen(),
      _buildMapScreen(appState),
      _buildAboutScreen(),
    ];

    return GradientBackground(
      child: Scaffold(
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
            if (_currentIndex == 0)
              const BackgroundBubbles(
                bubbles: [
                  BubbleData(top: 80, right: 28, size: 110, color: Color(0xFF5D4037), opacity: 0.08),
                  BubbleData(bottom: 140, left: 24, size: 90, color: Color(0xFFE05C0B), opacity: 0.08),
                  BubbleData(bottom: 60, right: 18, size: 70, color: Color(0xFF5D4037), opacity: 0.08),
                ],
              )
            else if (_currentIndex == 2)
              const BackgroundBubbles(
                bubbles: [
                  BubbleData(top: 100, right: 30, size: 100, color: Color(0xFF5D4037), opacity: 0.1),
                  BubbleData(top: 350, left: 20, size: 80, color: Color(0xFFDA650B), opacity: 0.1),
                  BubbleData(bottom: 200, right: 40, size: 120, color: Color(0xFF5D4037), opacity: 0.1),
                  BubbleData(bottom: 50, left: 30, size: 70, color: Color(0xFFDA650B), opacity: 0.1),
                ],
              ),
            SafeArea(child: screens[_currentIndex]),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          isSharer: false,
        ),
      ),
    );
  }

  Widget _buildHomeScreen(AppState appState) {
    final lang = appState.selectedLanguage;
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 88,
          child: IgnorePointer(
            child: SizedBox(
              height: 70,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.82,
                      child: Container(height: 2, color: Colors.grey.withValues(alpha: 0.18)),
                    ),
                  ),
                  Positioned(left: 28, top: 8, child: _decorBubble(18, AppTheme.primaryGreen, 0.2)),
                  Positioned(right: 34, top: 16, child: _decorBubble(24, AppTheme.accentOrange, 0.24)),
                  Positioned(left: 140, bottom: 10, child: _decorBubble(14, Colors.blueGrey, 0.16)),
                  Positioned(right: 120, bottom: 18, child: _decorBubble(16, Colors.teal, 0.18)),
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDEFC6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translations.get('welcome', lang),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF5D4037),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Translations.get('find_fresh_food', lang),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF5D4037),
                            fontFamily: 'Poppins',
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRScannerScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E342E),
                        foregroundColor: Colors.white,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.qr_code_scanner, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            Translations.get('scan_qr_claim', lang),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() => _currentIndex = 2);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E342E),
                        foregroundColor: Colors.white,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            Translations.get('find_smartbite_hub', lang),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                Translations.get('this_week_claimed', lang),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF5D4037),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RM 45 ${Translations.get('worth_of_food', lang)}',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: const Color(0xFFD97706),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          'RM 200 ${Translations.get('limit', lang)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.225,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD97706)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fair distribution ensures everyone gets access',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'My Claimed Items',
                style: TextStyle(
                  color: const Color(0xFF4E342E),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),
              _buildClaimedItemCard(
                'Fresh Vegetables Mix',
                'Expires in 2 days',
                'Claimed 1 hour ago',
                const Color(0xFF1F3A5F),
              ),
              const SizedBox(height: 12),
              _buildClaimedItemCard(
                'Bread Loaves (2x)',
                'Expires tomorrow',
                'Claimed yesterday',
                AppTheme.warningRed,
              ),
              const SizedBox(height: 12),
              _buildClaimedItemCard(
                'Canned Goods',
                'Expires in 1 week',
                'Claimed 2 days ago',
                const Color(0xFF1F3A5F),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.security, color: Color(0xFF5D4037)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your privacy is protected. Only you can see your claimed items.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF5D4037),
                            fontFamily: 'Poppins',
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapScreen(AppState appState) {
    return Stack(
      children: [

        Positioned(
          right: -20,
          top: 60,
          child: _decorBubble(120, const Color(0xFF5D4037), 0.08),
        ),
        Positioned(
          right: 40,
          bottom: 300,
          child: _decorBubble(80, const Color(0xFFDA650B), 0.1),
        ),
        SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SmartBite Hub Locations',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5D4037),
                  fontFamily: 'Poppins',
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Find collection points near you',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontFamily: 'Poppins',
                ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.my_location, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You are here',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Jalan University, Kuantan Campus',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.red.shade600,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.navigation, color: Colors.red.shade600),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const FakeMapWidget(showHubs: true),
          const SizedBox(height: 24),
          Text(
            'Available Hubs',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5D4037),
                  fontFamily: 'Poppins',
                ),
          ),
          const SizedBox(height: 16),
          _buildHubListItem(
            'Central Hub',
            'UMPSA Main Campus, Block A',
            '0.3 km away',
            '12 items available',
            const Color(0xFF5D4037),
          ),
          const SizedBox(height: 12),
          _buildHubListItem(
            'Kuantan Mall Hub',
            'East Coast Mall, Level G',
            '1.8 km away',
            '6 items available',
            const Color(0xFFDA650B),
          ),
          const SizedBox(height: 12),
          _buildHubListItem(
            'Community Hub',
            'Taman Gelora Community Center',
            '2.2 km away',
            '9 items available',
            const Color(0xFF5D4037),
          ),
          const SizedBox(height: 12),
          _buildHubListItem(
            'Hospital Hub',
            'Hospital Tengku Ampuan Afzan',
            '3.1 km away',
            '4 items available',
            const Color(0xFF1A237E),
          ),
        ],
      ),
        ),
      ],
    );
  }

  Widget _buildAboutScreen() {
    return const AboutUsScreen();
  }

  Widget _buildHubListItem(String name, String address, String distance, String items, Color statusColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(Icons.store, color: statusColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                              fontFamily: 'Poppins',
                            ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: statusColor),
                          const SizedBox(width: 4),
                          Text(
                            distance,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.access_time, size: 14, color: AppTheme.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            _getEstimatedTime(distance),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                  fontFamily: 'Poppins',
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    items,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showNavigationDialog(name, address, distance);
                    },
                    icon: const Icon(Icons.directions, size: 16),
                    label: const Text('Navigate'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D4037),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showHubDetails(name, address, items);
                    },
                    icon: const Icon(Icons.info_outline, size: 16),
                    label: const Text('Info'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: statusColor,
                      side: BorderSide(color: statusColor),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getEstimatedTime(String distance) {
    final distanceValue = double.tryParse(distance.split(' ').first) ?? 1.0;
    final minutes = (distanceValue * 12).round();
    return '~${minutes}min walk';
  }

  void _showNavigationDialog(String hubName, String address, String distance) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.navigation, color: AppTheme.primaryGreen),
            const SizedBox(width: 8),
            Text('Navigate to $hubName'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: $address'),
            const SizedBox(height: 8),
            Text('Distance: $distance'),
            const SizedBox(height: 8),
            Text('Estimated time: ${_getEstimatedTime(distance)}'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppTheme.primaryGreen, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This will open your preferred navigation app',
                      style: TextStyle(color: AppTheme.primaryGreen),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening navigation to $hubName...'),
                  backgroundColor: AppTheme.primaryGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
            child: const Text('Navigate', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showHubDetails(String hubName, String address, String items) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.store, color: Color(0xFF5D4037)),
            const SizedBox(width: 8),
            Text(
              hubName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📍 Address: $address', style: const TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            Text('📦 $items', style: const TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            const Text('🕒 Operating Hours: 9:00 AM - 6:00 PM', style: TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            const Text('📞 Contact: +60 12-345 6789', style: TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tips_and_updates, color: AppTheme.accentOrange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Present your QR code to collect food items',
                      style: TextStyle(color: AppTheme.accentOrange, fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF1A237E), fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimedItemCard(String title, String expiry, String claimedTime, Color statusColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(Icons.fastfood, color: statusColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    expiry,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    claimedTime,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusColor == AppTheme.successGreen ? 'Safe' : 'Use Soon',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decorBubble(double size, Color color, double alpha) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: alpha),
        shape: BoxShape.circle,
      ),
    );
  }
}
