import 'package:flutter/material.dart';

class AboutUsBackgroundDecoration extends StatelessWidget {
  const AboutUsBackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _AboutUsBackgroundPainter(),
      ),
    );
  }
}

class _AboutUsBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    paint.color = const Color(0xFFFFEE8C).withOpacity(0.25);
    canvas.drawCircle(Offset(size.width * 0.2, 80), 60, paint);
    paint.color = const Color(0xFFBCA17A).withOpacity(0.18);
    canvas.drawCircle(Offset(size.width * 0.8, 180), 40, paint);
    paint.color = const Color(0xFFF8F4FF).withOpacity(0.18);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.7), 50, paint);
    paint.color = const Color(0xFFFDEFC6).withOpacity(0.18);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.85), 70, paint);

    paint.color = const Color(0xFFDA650B).withOpacity(0.13);
    paint.strokeWidth = 4;
    paint.style = PaintingStyle.stroke;
    final path1 = Path();
    path1.moveTo(size.width * 0.1, size.height * 0.2);
    path1.cubicTo(size.width * 0.3, size.height * 0.25, size.width * 0.7, size.height * 0.15, size.width * 0.9, size.height * 0.22);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width * 0.15, size.height * 0.8);
    path2.cubicTo(size.width * 0.4, size.height * 0.9, size.width * 0.6, size.height * 0.7, size.width * 0.85, size.height * 0.8);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
