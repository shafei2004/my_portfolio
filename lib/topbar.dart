import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/theme_provider.dart';
import 'package:my_portfolio/core/utils/navigation_provider.dart';
import 'package:my_portfolio/features/about/pages/about_page.dart';
import 'package:my_portfolio/features/contacts/pages/contact_page.dart';
import 'package:my_portfolio/features/home/pages/home_page.dart';
import 'package:my_portfolio/features/projects/pages/projects_page.dart';
import 'package:my_portfolio/core/widgets/custom_cursor.dart';
import 'package:my_portfolio/core/widgets/footer_section.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final ValueNotifier<double> _scrollProgress = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = Provider.of<NavigationProvider>(context, listen: false);
      nav.scrollController.addListener(() => _onScroll(nav));
    });
  }

  void _onScroll(NavigationProvider nav) {
    if (!nav.scrollController.hasClients) return;

    final homeContext = nav.homeKey.currentContext;
    final aboutContext = nav.aboutKey.currentContext;
    final projectsContext = nav.projectsKey.currentContext;
    final contactContext = nav.contactKey.currentContext;

    if (homeContext == null ||
        aboutContext == null ||
        projectsContext == null ||
        contactContext == null) return;

    final scrollOffset = nav.scrollController.offset;
    int newIndex = 0;
    
    try {
      final double aboutPos = _getOffset(nav, aboutContext);
      final double projectsPos = _getOffset(nav, projectsContext);
      final double contactPos = _getOffset(nav, contactContext);

      if (scrollOffset >= contactPos - 300) {
        newIndex = 3;
      } else if (scrollOffset >= projectsPos - 300) {
        newIndex = 2;
      } else if (scrollOffset >= aboutPos - 300) {
        newIndex = 1;
      } else {
        newIndex = 0;
      }
    } catch (_) {}

    nav.updateIndex(newIndex);

    // Update progress bar
    if (nav.scrollController.hasClients) {
      final max = nav.scrollController.position.maxScrollExtent;
      if (max > 0) {
        _scrollProgress.value = (scrollOffset / max).clamp(0.0, 1.0);
      }
    }
  }

  double _getOffset(NavigationProvider nav, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final double pos = box.localToGlobal(Offset.zero).dy + nav.scrollController.offset;
    // We need the vertical position relative to the scroll view
    return pos - 150; // Offset for navbar height
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      body: CustomCursor(
        child: Stack(
          children: [
          // 📊 Scroll Progress Bar (Top-most)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 3,
            child: ValueListenableBuilder<double>(
              valueListenable: _scrollProgress,
              builder: (context, progress, child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(0.5),
                          colorScheme.primary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            controller: navProvider.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                HomePage(key: navProvider.homeKey),
                AboutPage(key: navProvider.aboutKey),
                ProjectsPage(key: navProvider.projectsKey),
                ContactPage(key: navProvider.contactKey),
                const FooterSection(),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: SafeArea(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: colorScheme.onSurface.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildNavItem("Home", Icons.home_rounded, 0, isDarkMode, navProvider),
                          _buildNavItem("About", Icons.person_rounded, 1, isDarkMode, navProvider),
                          _buildNavItem("Projects", Icons.work_rounded, 2, isDarkMode, navProvider),
                          _buildNavItem("Contact", Icons.mail_rounded, 3, isDarkMode, navProvider),
                          const SizedBox(width: 10),
                          Container(
                            height: 30,
                            width: 1,
                            color: colorScheme.onSurface.withOpacity(0.1),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(
                              isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                              color: isDarkMode ? colorScheme.primary : colorScheme.onSurface,
                              size: 20,
                            ),
                            onPressed: () => themeProvider.toggleTheme(),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, int index, bool isDarkMode, NavigationProvider nav) {
    final isSelected = nav.selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => nav.scrollToSection(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.6),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
