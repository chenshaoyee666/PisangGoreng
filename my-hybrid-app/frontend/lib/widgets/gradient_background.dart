import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFFFF176), // Yellow at bottom
            Color(0xFFFFF9E6),
            Colors.white,      // White at top
          ],
          stops: [0.0, 0.3, 1.0],
        ),
      ),
      child: child,
    );
  }
}
