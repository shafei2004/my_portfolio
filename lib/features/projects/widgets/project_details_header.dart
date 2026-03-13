import 'package:flutter/material.dart';

class ProjectDetailsHeader extends StatelessWidget {
  final String category;
  final String title;
  final String description;

  const ProjectDetailsHeader({
    super.key,
    required this.category,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (category.isNotEmpty)
          Text(
            category,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        const SizedBox(height: 8),
        Text(title,
            style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          description,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
        ),
      ],
    );
  }
}
