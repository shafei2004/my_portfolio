import 'package:flutter/material.dart';

class ProjectImageSlider extends StatelessWidget {
  final List<String> images;
  const ProjectImageSlider({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 480, // Increased height for vertical portraits
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        padding: const EdgeInsets.symmetric(vertical: 10),
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (_, i) {
          final url = images[i];
          return Container(
            width: 280, // Standard width for phone screenshots
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: theme.colorScheme.surfaceVariant,
                  child: const Center(child: Icon(Icons.broken_image, size: 40)),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
