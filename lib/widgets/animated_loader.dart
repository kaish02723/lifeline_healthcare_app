import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicalCrossLoader extends StatefulWidget {
  const MedicalCrossLoader({super.key});

  @override
  State<MedicalCrossLoader> createState() => _MedicalCrossLoaderState();
}

class _MedicalCrossLoaderState extends State<MedicalCrossLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i * 0.3;
            final value = ((_controller.value + delay) % 1.0);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.4 + (value * 0.6)),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
