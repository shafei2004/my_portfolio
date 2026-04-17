import 'package:flutter/material.dart';

class ScrollAppearance extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final double threshold;
  final Offset offset;

  const ScrollAppearance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.threshold = 0.1,
    this.offset = const Offset(0, 0.1),
  });

  @override
  Widget build(BuildContext context) {
    // 🛠 EMERGENCY BYPASS: Displaying child immediately to detect the layout error
    return child;
  }
}
