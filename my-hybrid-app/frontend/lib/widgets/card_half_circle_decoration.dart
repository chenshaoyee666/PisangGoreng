import 'package:flutter/material.dart';

class CardHalfCircleDecoration extends StatelessWidget {
  final double size;
  final Alignment alignment;
  final Color color;

  const CardHalfCircleDecoration({
    super.key,
    this.size = 100,
    this.alignment = Alignment.topRight,
    this.color = const Color(0xFFFFF6E5), // Reverted to original color
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(size),
            bottomLeft: Radius.circular(size),
          ),
        ),
      ),
    );
  }
}
