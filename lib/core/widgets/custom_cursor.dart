import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  final ValueNotifier<Offset> _position = ValueNotifier(Offset.zero);
  final ValueNotifier<bool> _isHovering = ValueNotifier(false);

  bool get _isDesktop => !kIsWeb && (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.linux);
  bool get _showCustomCursor => kIsWeb || _isDesktop;

  @override
  Widget build(BuildContext context) {
    if (!_showCustomCursor) return widget.child;

    return MouseRegion(
      onHover: (event) {
        _position.value = event.localPosition;
      },
      opaque: false,
      child: Stack(
        children: [
          widget.child,
          ValueListenableBuilder<Offset>(
            valueListenable: _position,
            builder: (context, pos, _) {
              return ValueListenableBuilder<bool>(
                valueListenable: _isHovering,
                builder: (context, hovering, _) {
                  return IgnorePointer(
                    child: Stack(
                      children: [
                        // ⭕ Outer Ring (Fluid)
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 100),
                          left: pos.dx - (hovering ? 30 : 20),
                          top: pos.dy - (hovering ? 30 : 20),
                          child: Container(
                            width: hovering ? 60 : 40,
                            height: hovering ? 60 : 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        // 📍 Inner Dot (Precise)
                        Positioned(
                          left: pos.dx - 4,
                          top: pos.dy - 4,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
