import 'package:flutter/material.dart';
import 'dart:math';

class SpeedometerPainter extends CustomPainter {
  final double currentSpeed; // e.g. 0 to 40
  final double maxSpeed;

  SpeedometerPainter({
    required this.currentSpeed,
    this.maxSpeed = 40.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final bgPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..shader = const SweepGradient(
        colors: [Colors.green, Colors.yellow, Colors.red],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // Draw background arc (from 150 degrees to 30 degrees)
    const startAngle = 150 * (pi / 180);
    const sweepAngle = 240 * (pi / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Draw active arc based on speed
    final speedPercent = (currentSpeed / maxSpeed).clamp(0.0, 1.0);
    final activeSweep = sweepAngle * speedPercent;
    
    if (activeSweep > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        activeSweep,
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SpeedometerPainter oldDelegate) {
    return oldDelegate.currentSpeed != currentSpeed;
  }
}
