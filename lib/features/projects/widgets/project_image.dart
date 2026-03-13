import 'package:flutter/material.dart';

class ProjectImage extends StatelessWidget {
  final String imageUrl;
  final bool isDark;

  const ProjectImage({
    super.key,
    required this.imageUrl,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              height: double.infinity,
              width: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildFallback(theme),
            )
          : _buildFallback(theme),
    );
  }

  Widget _buildFallback(ThemeData theme) => Container(
        height: double.infinity,
        width: 90,
        color: isDark ? Colors.grey[900] : Colors.grey[200],
        child: Icon(
          Icons.broken_image,
          color: theme.iconTheme.color?.withOpacity(0.6),
        ),
      );
}
