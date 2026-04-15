import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityAnimator extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double threshold;

  const VisibilityAnimator({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.threshold = 0.2,
  });

  @override
  State<VisibilityAnimator> createState() => _VisibilityAnimatorState();
}

class _VisibilityAnimatorState extends State<VisibilityAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > widget.threshold && !_isVisible) {
          _isVisible = true;
          Future.delayed(widget.delay, () {
            if (mounted) _controller.forward();
          });
        }
      },
      child: FadeTransition(
        opacity: _controller,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
          )),
          child: widget.child,
        ),
      ),
    );
  }
}
