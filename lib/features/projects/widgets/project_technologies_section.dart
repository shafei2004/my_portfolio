import 'package:flutter/material.dart';

class ProjectTechnologiesSection extends StatelessWidget {
  final List<String> technologies;
  const ProjectTechnologiesSection({super.key, required this.technologies});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Technologies Used",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: technologies
              .map((t) => Chip(
                    label: Text(t),
                    backgroundColor: theme.colorScheme.surfaceVariant,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
