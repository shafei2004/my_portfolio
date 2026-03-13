import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_portfolio/core/utils/app_router.dart';
import 'package:my_portfolio/core/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _loading = true;
  String? _error;
  Map<String, dynamic>? _homeData;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // load remote data
    _loadHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadHome() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final res = await supabase
          .from('home')
          .select()
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (res == null) {
        setState(() {
          _homeData = null;
          _loading = false;
          _error = null; // allow fallback to local assets
        });
        return;
      }

      if (res is Map) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(res as Map);
        setState(() {
          _homeData = data;
          _loading = false;
        });
      } else {
        // unexpected format
        setState(() {
          _homeData = null;
          _loading = false;
          _error = 'Unexpected response format from server';
        });
      }
    } catch (e, st) {
      debugPrint('loadHome error: $e\n$st');
      setState(() {
        _homeData = null;
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // loading state: show spinner while fetching (keeps animations running)
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // error state: show error and retry button
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Failed to load home data: $_error', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loadHome,
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    // Use data from _homeData if exists, otherwise fall back to the hard-coded defaults
    final heroUrl = (_homeData != null && (_homeData!['hero_image_url'] as String?)?.isNotEmpty == true)
        ? _homeData!['hero_image_url'] as String
        : null;
    final name = _homeData != null && (_homeData!['name'] as String?)?.isNotEmpty == true
        ? _homeData!['name'] as String
        : 'Mohamed El-Shafei';
    final role = _homeData != null && (_homeData!['role'] as String?)?.isNotEmpty == true
        ? _homeData!['role'] as String
        : 'Flutter Developer | Mobile & Web';
    final shortBio = _homeData != null && (_homeData!['short_bio'] as String?)?.isNotEmpty == true
        ? _homeData!['short_bio'] as String
        : 'Software engineer with a passion for Mobile App development using Flutter.';

    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // صورة البروفايل: لو فيه رابط نعرض NetworkImage وإلا نعرض asset
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: heroUrl != null
                        ? NetworkImage(heroUrl) as ImageProvider
                        :  AssetImage(MyPhoto),
                    backgroundColor: theme.colorScheme.background,
                  ),
                  const SizedBox(height: 24),

                  // الاسم
                  Text(
                    name != null ? name : 'Mohamed El-Shafei',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // التخصص
                  Text(
                    role != null ? role : 'Flutter Developer | Mobile & Web',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // الوصف
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      shortBio != null ? shortBio : 'Software engineer with a passion for Mobile App development using Flutter.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // الأزرار
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => GoRouter.of(context).push(AppRouter.kContactsPage),
                        icon: const Icon(Icons.contact_mail, size: 22),
                        label: const Text("Get Contact"),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        onPressed: () => GoRouter.of(context).push(AppRouter.kProjectsPage),
                        icon: const Icon(Icons.arrow_right_alt, size: 22, color: Colors.white),
                        label: const Text("View My Work", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
