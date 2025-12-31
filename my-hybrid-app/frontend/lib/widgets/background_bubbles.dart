import 'package:flutter/material.dart';

class BackgroundBubbles extends StatelessWidget {
  final List<BubbleData> bubbles;

  const BackgroundBubbles({super.key, this.bubbles = const []});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: bubbles.map((bubble) {
        return Positioned(
          top: bubble.top,
          left: bubble.left,
          right: bubble.right,
          bottom: bubble.bottom,
          child: Container(
            width: bubble.size,
            height: bubble.size,
            decoration: BoxDecoration(
              color: bubble.color.withOpacity(bubble.opacity),
              shape: BoxShape.circle,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class BubbleData {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double size;
  final Color color;
  final double opacity;

  const BubbleData({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.size,
    required this.color,
    this.opacity = 0.18,
  });
}

// Example usage:
// BackgroundBubbles(
//   bubbles: [
//     BubbleData(top: 40, left: 20, size: 120, color: Colors.amber),
//     BubbleData(bottom: 80, right: 30, size: 80, color: Colors.brown),
//   ],
// )
