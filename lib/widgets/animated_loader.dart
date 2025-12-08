import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class MedicalHeartECGLoader extends StatefulWidget {
  final double width;
  final Color color;

  const MedicalHeartECGLoader({
    super.key,
    this.width = 220,
    this.color = Colors.red,
  });

  @override
  State<MedicalHeartECGLoader> createState() => _MedicalHeartECGLoaderState();
}

class _MedicalHeartECGLoaderState extends State<MedicalHeartECGLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          size: Size(widget.width, 80),
          painter: HeartECGPainter(
            progress: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class HeartECGPainter extends CustomPainter {
  final double progress;
  final Color color;

  HeartECGPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    double w = size.width;
    double h = size.height / 2;

    double x = -w + (progress * w);

    // ECG waveform pattern
    for (double i = 0; i < w; i++) {
      double dx = i + x;

      double dy;
      if (dx % 120 < 20) {
        dy = h; // flat line
      } else if (dx % 120 < 40) {
        dy = h - 25; // slight up
      } else if (dx % 120 < 60) {
        dy = h + 30; // downward point
      } else if (dx % 120 < 80) {
        dy = h - 70; // big up spike (heartbeat)
      } else {
        dy = h; // flat again
      }

      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant HeartECGPainter oldDelegate) => true;
}
