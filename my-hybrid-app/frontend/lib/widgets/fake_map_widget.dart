import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class FakeMapWidget extends StatelessWidget {
  final bool showHubs;
  final bool showRider;
  final String? riderLocation;

  const FakeMapWidget({
    super.key,
    this.showHubs = false,
    this.showRider = false,
    this.riderLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          _buildMapBackground(),
          
          const Positioned(
            left: 180,
            top: 200,
            child: UserLocationMarker(),
          ),
          
          if (showHubs) ...[
            const Positioned(
              left: 120,
              top: 120,
              child: SmartBiteHubMarker(
                hubName: "Central Hub",
                distance: "0.8 km",
              ),
            ),
            const Positioned(
              left: 280,
              top: 160,
              child: SmartBiteHubMarker(
                hubName: "Mall Hub",
                distance: "1.2 km",
              ),
            ),
            const Positioned(
              left: 100,
              top: 280,
              child: SmartBiteHubMarker(
                hubName: "Community Hub",
                distance: "1.5 km",
              ),
            ),
          ],
          
          if (showRider && riderLocation != null) ...[
            Positioned(
              left: riderLocation == "pickup" ? 160 : 
                     riderLocation == "onway" ? 140 : 180,
              top: riderLocation == "pickup" ? 180 : 
                    riderLocation == "onway" ? 160 : 200,
              child: const RiderMarker(),
            ),
          ],
          
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    return CustomPaint(
      size: const Size(double.infinity, 400),
      painter: MapBackgroundPainter(),
    );
  }
}

class MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3;

    canvas.drawLine(
      const Offset(0, 100),
      Offset(size.width, 100),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 200),
      Offset(size.width, 200),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 300),
      Offset(size.width, 300),
      paint,
    );

    canvas.drawLine(
      const Offset(100, 0),
      Offset(100, size.height),
      paint,
    );
    canvas.drawLine(
      const Offset(200, 0),
      Offset(200, size.height),
      paint,
    );
    canvas.drawLine(
      const Offset(300, 0),
      Offset(300, size.height),
      paint,
    );

    final buildingPaint = Paint()
      ..color = Colors.grey.shade600;

    final buildings = [
      const Rect.fromLTWH(50, 50, 40, 40),
      const Rect.fromLTWH(250, 50, 60, 40),
      const Rect.fromLTWH(60, 250, 30, 40),
      const Rect.fromLTWH(250, 250, 40, 40),
      const Rect.fromLTWH(150, 130, 35, 35),
      const Rect.fromLTWH(320, 130, 25, 35),
    ];

    for (final building in buildings) {
      canvas.drawRect(building, buildingPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UserLocationMarker extends StatelessWidget {
  const UserLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'You are here',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class SmartBiteHubMarker extends StatelessWidget {
  final String hubName;
  final String distance;

  const SmartBiteHubMarker({
    super.key,
    required this.hubName,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: AppTheme.primaryGreen,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.restaurant,
            color: Colors.white,
            size: 10,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                hubName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                distance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RiderMarker extends StatelessWidget {
  const RiderMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            color: AppTheme.accentOrange,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.motorcycle,
            color: Colors.white,
            size: 8,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: AppTheme.accentOrange,
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            'Rider',
            style: TextStyle(
              color: Colors.white,
              fontSize: 7,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}