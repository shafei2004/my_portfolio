import 'package:flutter/material.dart';

class BuildCard extends StatefulWidget {
  const BuildCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.year,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String year;
  final String description;

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? colorScheme.primary.withOpacity(0.5) : colorScheme.onSurface.withOpacity(0.08),
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? colorScheme.primary.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                blurRadius: _isHovered ? 30 : 15,
                offset: _isHovered ? const Offset(0, 15) : const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row/Column (Responsive)
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(theme, colorScheme),
                    const SizedBox(height: 12),
                    _buildYearBadge(colorScheme),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildTitle(theme, colorScheme)),
                    const SizedBox(width: 12),
                    _buildYearBadge(colorScheme),
                  ],
                ),

              const SizedBox(height: 12),
              Text(
                widget.subtitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme, ColorScheme colorScheme) {
    return Text(
      widget.title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: _isHovered ? colorScheme.primary : null,
      ),
    );
  }

  Widget _buildYearBadge(ColorScheme colorScheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _isHovered ? colorScheme.primary : colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        widget.year,
        style: TextStyle(
          color: _isHovered ? Colors.black : colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
