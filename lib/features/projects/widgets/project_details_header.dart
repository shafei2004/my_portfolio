import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category.toUpperCase(),
              style: GoogleFonts.cairo(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
          ),
        const SizedBox(height: 16),
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onSurface,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: GoogleFonts.cairo(
            fontSize: 16,
            height: 1.6,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );

  }
}
