import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbite/models/food_item.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../widgets/fake_map_widget.dart';
import '../widgets/background_bubbles.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  final String trackingNumber;
  final String foodName;
  final FoodItem foodItem;

  const DeliveryTrackingScreen({
    super.key,
    required this.trackingNumber,
    required this.foodName,
    required this.foodItem,
  });

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  int _currentStep = 0;
  String _riderLocation = "pickup";

  @override
  void initState() {
    super.initState();
    _startTrackingAnimation();
  }

  void _startTrackingAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentStep = 1;
          _riderLocation = "onway";
        });
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _currentStep = 2;
          _riderLocation = "hub";
        });
      }
    });

    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          _currentStep = 3;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final lang = appState.selectedLanguage;
        return Scaffold(
          backgroundColor: const Color(0xFFFFF9EC),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF9EC),
            title: Text(Translations.get('delivery_tracking', lang), style: const TextStyle(fontFamily: 'Poppins')),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Stack(
            children: [

              BackgroundBubbles(
                bubbles: [
                  BubbleData(top: 10, left: 40, size: 70, color: Color(0xFFFFEE8C)),
                  BubbleData(top: 20, right: 15, size: 55, color: Color(0xFFBCA17A)),
                  BubbleData(top: 60, left: 20, size: 100, color: Color(0xFFFFF6E5)),
                  BubbleData(bottom: 120, right: 30, size: 80, color: Color(0xFFBCA17A)),
                  BubbleData(top: 180, right: -30, size: 90, color: Color(0xFFFFEE8C)),
                  BubbleData(bottom: 350, left: -20, size: 70, color: Color(0xFFF8F4FF)),
                  BubbleData(top: 350, left: 30, size: 65, color: Color(0xFFFFEE8C)),
                  BubbleData(bottom: 180, left: 15, size: 55, color: Color(0xFFBCA17A)),
                  BubbleData(top: 550, right: 25, size: 75, color: Color(0xFFF8F4FF)),
                  BubbleData(bottom: 60, right: -20, size: 60, color: Color(0xFFFFF6E5)),
                ],
              ),
              SingleChildScrollView(
            padding: const EdgeInsets.all(16),
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
                          Translations.get('food_pickup_progress', lang),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF5D4037),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${Translations.get('tracking', lang)}: ${widget.trackingNumber}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5D4037),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${Translations.get('item', lang)}: ${widget.foodName}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5D4037),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  Translations.get('live_tracking', lang),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: const Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 12),
                FakeMapWidget(
                  showHubs: true,
              showRider: _currentStep < 3,
              riderLocation: _riderLocation,
            ),

            const SizedBox(height: 24),

            Text(
              'Pickup Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: const Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 16),

            _buildProgressStep(
              0,
              'Processing',
              'Your food donation is being processed',
              Icons.inventory_2,
              isCompleted: _currentStep > 0,
              isActive: _currentStep == 0,
            ),
            _buildProgressStep(
              1,
              'Driver Assigned',
              'Ahmad (Rider #1249) is on the way',
              Icons.person,
              isCompleted: _currentStep > 1,
              isActive: _currentStep == 1,
            ),
            _buildProgressStep(
              2,
              'On the Way',
              'Driver is picking up your food',
              Icons.motorcycle,
              isCompleted: _currentStep > 2,
              isActive: _currentStep == 2,
            ),
            _buildProgressStep(
              3,
              'Delivered to Hub',
              'Food is now available for collection',
              Icons.restaurant,
              isCompleted: _currentStep >= 3,
              isActive: false,
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Color(0xFFDA650B)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Completion',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          _currentStep >= 3 ? 'Completed!' : '${15 - (_currentStep * 3)} minutes',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _currentStep >= 3 ? const Color(0xFF5D4037) : const Color(0xFFDA650B),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (_currentStep >= 1 && _currentStep < 3) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF5D4037).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF5D4037).withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver Contact',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5D4037),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFF5D4037), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Ahmad (Rider #1249)',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Color(0xFF5D4037), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '+60 12-345 6789',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            if (_currentStep >= 3) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF5D4037).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF5D4037).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF5D4037),
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Food Successfully Delivered!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF5D4037),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your food is now available at Central Hub for collection by recipients.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4037),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _currentStep >= 3 ? 'Back to Dashboard' : 'Continue Tracking',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
            ],
          ),
      );
      },
    );
  }

  Widget _buildProgressStep(
    int stepIndex,
    String title,
    String description,
    IconData icon, {
    required bool isCompleted,
    required bool isActive,
  }) {
    final Color stepColor = isCompleted
        ? const Color(0xFF5D4037)
        : isActive
            ? const Color(0xFFDA650B)
            : Colors.grey;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: stepColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: stepColor, width: 2),
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: stepColor,
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: stepColor,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          if (isActive) ...[
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDA650B)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}