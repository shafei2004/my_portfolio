import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectFeatures extends StatelessWidget {
  final List<String> features;
  final bool isDark;

  const ProjectFeatures({
    super.key,
    required this.features,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const maxVisible = 3;
    final visible = features.take(maxVisible).toList();
    final remaining = features.length - visible.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          runSpacing: 6,
          children: [
            ...visible.map(
              (f) => Chip(
                label: Text(
                  f,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: colorScheme.primary.withOpacity(0.1),
                side: BorderSide(color: colorScheme.primary.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                visualDensity:
                    const VisualDensity(horizontal: -2, vertical: -2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            if (remaining > 0)
              Chip(
                label: Text(
                  "+$remaining more",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: colorScheme.onSurface.withOpacity(0.05),
                side: BorderSide(color: colorScheme.onSurface.withOpacity(0.1)),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                visualDensity:
                    const VisualDensity(horizontal: -2, vertical: -2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
          ],
        );
      },
    );
  }
}
