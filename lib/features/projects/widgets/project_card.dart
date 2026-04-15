import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/core/utils/app_router.dart';
import '../models/project_model.dart';
import 'project_image.dart';
import 'project_features.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isDark;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isDark,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

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
              margin: const EdgeInsets.only(bottom: 24),
              height: isMobile ? null : 260, // Fixed height on desktop for uniformity
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered ? colorScheme.primary.withOpacity(0.5) : colorScheme.onSurface.withOpacity(0.08),
                  width: _isHovered ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered ? colorScheme.primary.withOpacity(0.12) : Colors.black.withOpacity(0.05),
                    blurRadius: _isHovered ? 30 : 15,
                    offset: _isHovered ? const Offset(0, 15) : const Offset(0, 8),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => GoRouter.of(context).push('${AppRouter.kProjectsDetailsPage}?slug=${widget.project.slug}'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: isMobile
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: 110,
                                // height: double.infinity,
                                child: ProjectImage(imageUrl: widget.project.image, isDark: widget.isDark),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildProjectInfo(theme, colorScheme, isMobile: true),
                            ),
                          ],
                        )

                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: 160, // Vertical orientation
                                height: double.infinity,
                                child: ProjectImage(imageUrl: widget.project.image, isDark: widget.isDark),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildProjectInfo(theme, colorScheme, isMobile: false),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectInfo(ThemeData theme, ColorScheme colorScheme, {required bool isMobile}) {
    final textWidget = Text(
      widget.project.description,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withOpacity(0.7),
        height: 1.5,
      ),
      maxLines: isMobile ? 3 : 4,
      overflow: TextOverflow.ellipsis,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.project.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: _isHovered ? colorScheme.primary : null,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        isMobile ? textWidget : Expanded(child: textWidget),
        const SizedBox(height: 12),
        ProjectFeatures(
          features: widget.project.features,
          isDark: widget.isDark,
        ),
      ],
    );
  }
}
