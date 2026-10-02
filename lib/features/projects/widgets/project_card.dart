import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
                  color: _isHovered ? colorScheme.primary.withValues(alpha: 0.5) : colorScheme.onSurface.withValues(alpha: 0.08),
                  width: _isHovered ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered ? colorScheme.primary.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.05),
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
                      ? _buildMobileContent(context, theme, colorScheme)
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDesktopImageSection(context),
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

  Widget _buildDesktopImageSection(BuildContext context) {
    final hasGooglePlay = widget.project.googlePlayUrl != null &&
        widget.project.googlePlayUrl!.trim().isNotEmpty;
    const double width = 160;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ProjectImage(imageUrl: widget.project.image, isDark: widget.isDark),
            if (hasGooglePlay) ...[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 55,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.85),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 4,
                right: 4,
                child: Center(
                  child: _buildGooglePlayBadge(context, widget.project.googlePlayUrl!, isMobile: false),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    final hasGooglePlay = widget.project.googlePlayUrl != null &&
        widget.project.googlePlayUrl!.trim().isNotEmpty;
    const double imageWidth = 115;
    // 💡 المقاس السابق كان 115، تم رفعه لـ 145 ليكون أطول وأكثر تناسقاً مع ارتفاع الكارت
    const double imageHeight = 145;

    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: imageWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: ProjectImage(imageUrl: widget.project.image, isDark: widget.isDark),
                    ),
                  ),
                  if (hasGooglePlay) const SizedBox(height: 42),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildProjectInfo(theme, colorScheme, isMobile: true),
            ),
          ],
        ),
        if (hasGooglePlay)
          Positioned(
            bottom: 0,
            left: 0,
            width: imageWidth,
            child: Center(
              child: _buildGooglePlayBadge(context, widget.project.googlePlayUrl!, isMobile: true),
            ),
          ),
      ],
    );
  }

  Widget _buildGooglePlayBadge(BuildContext context, String url, {required bool isMobile}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final uri = Uri.tryParse(url.startsWith("http") ? url.trim() : "https://${url.trim()}");
          if (uri != null && await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Could not open Google Play link.")),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 10,
            vertical: isMobile ? 4 : 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF01875F), // Google Play official emerald green
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.googlePlay,
                  size: isMobile ? 10 : 12,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  "View on Google play",
                  style: GoogleFonts.cairo(
                    fontSize: isMobile ? 10 : 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectInfo(ThemeData theme, ColorScheme colorScheme, {required bool isMobile}) {
    final textWidget = Text(
      widget.project.description,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.7),
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
