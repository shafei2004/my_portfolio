import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/navigation_provider.dart';
import 'package:my_portfolio/core/widgets/scroll_appearance.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_portfolio/core/utils/constants.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  bool _loading = true;
  Map<String, dynamic>? _homeData;

  @override
  void initState() {
    super.initState();
    _loadHome();
  }

  Future<void> _loadHome() async {
    setState(() => _loading = true);
    try {
      final res = await supabase
          .from('home')
          .select()
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle()
          .timeout(const Duration(seconds: 10));

      if (res != null && res is Map) {
        setState(() {
          _homeData = Map<String, dynamic>.from(res);
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      debugPrint('loadHome error: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final heroUrl = _homeData?['hero_image_url'] as String?;

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 1000;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: isDesktop ? const Alignment(0.6, -0.3) : const Alignment(0.8, -0.6),
              radius: 1.2,
              colors: [
                colorScheme.primary.withOpacity(0.08),
                Colors.transparent,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? constraints.maxWidth * 0.1 : 24,
            vertical: isDesktop ? 100 : 120,
          ),
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildInfoSection(context, isDesktop),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 2,
                      child: _buildProfileImage(heroUrl, colorScheme, isDesktop),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileImage(heroUrl, colorScheme, isDesktop),
                    const SizedBox(height: 48),
                    _buildInfoSection(context, isDesktop),
                  ],
                ),
        );
      },
    );

  }

  Widget _buildProfileImage(String? heroUrl, ColorScheme colorScheme, bool isDesktop) {
    final double baseSize = isDesktop ? 380 : 260;
    final double radius = isDesktop ? 160 : 120;

    return ScrollAppearance(
      delay: const Duration(milliseconds: 300),
      offset: const Offset(0, -0.05), // Slide down
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dynamic Glow Background
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Container(
                width: baseSize + (value * 20),
                height: baseSize + (value * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.2 + (value * 0.1)),
                      blurRadius: 60 + (value * 20),
                      spreadRadius: 15 + (value * 10),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.primary.withOpacity(0.3),
                width: 2.5,
              ),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: heroUrl != null ? NetworkImage(heroUrl) as ImageProvider : AssetImage(MyPhoto),
              backgroundColor: colorScheme.surface,
            ),
          ),
        ],
      ),
    );

  }

  Widget _buildInfoSection(BuildContext context, bool isDesktop) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final name = _homeData?['name'] as String? ?? 'Mohamed El-Shafei';
    final role = _homeData?['role'] as String? ?? 'Flutter Developer | Mobile & Web';
    final shortBio = _homeData?['short_bio'] as String? ?? 'Software engineer with a passion for Mobile App development using Flutter.';

    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 👑 Name
        ScrollAppearance(
          delay: const Duration(milliseconds: 200),
          offset: const Offset(-0.05, 0), // Slide from left
          child: Text(
            name,
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -1.5,
              fontSize: isDesktop ? 64 : 40,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 💼 Role
        ScrollAppearance(
          delay: const Duration(milliseconds: 400),
          offset: const Offset(-0.2, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
            ),
            child: Text(
              role,
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontSize: isDesktop ? 22 : 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 📖 Bio
        ScrollAppearance(
          delay: const Duration(milliseconds: 600),
          offset: const Offset(-0.2, 0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              shortBio,
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
                height: 1.6,
                fontSize: isDesktop ? 20 : 17,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),

        // 🚀 Actions
        ScrollAppearance(
          delay: const Duration(milliseconds: 800),
          offset: const Offset(0, 0.05), // Slide up
          child: Wrap(
            alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
            spacing: 20,
            runSpacing: 16,
            children: [
              _buildActionButton(
                context: context,
                label: "View My Work",
                icon: Icons.rocket_launch_rounded,
                isPrimary: true,
                onPressed: () => Provider.of<NavigationProvider>(context, listen: false).scrollToSection(2),
              ),
              _buildActionButton(
                context: context,
                label: "Get In Touch",
                icon: Icons.chat_bubble_rounded,
                isPrimary: false,
                onPressed: () => Provider.of<NavigationProvider>(context, listen: false).scrollToSection(3),
              ),
            ],
          ),
        ),
      ],
    );


  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          color: isPrimary ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.primary,
            width: 2,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isPrimary ? Colors.black : colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isPrimary ? Colors.black : colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}