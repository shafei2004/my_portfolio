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
  bool _isPaused = false;
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
      _isPaused = false;
    });

    try {
      final res = await supabase
          .from('home')
          .select()
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle()
          .timeout(const Duration(seconds: 10)); // Add timeout

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
          _error = null; // Clear any previous error
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
      
      String errorMessage = e.toString();
      bool isPausedError = errorMessage.contains('paused') || 
                           errorMessage.contains('timeout') ||
                           errorMessage.contains('connection') ||
                           errorMessage.contains('Failed host lookup') ||
                           errorMessage.contains('SocketException') ||
                           errorMessage.contains('Network is unreachable');

      setState(() {
        _homeData = null; // Still null, will use fallback data
        _loading = false;
        _error = isPausedError 
            ? "المشروع متوقف مؤقتاً. يتم عرض البيانات المحلية"
            : "حدث خطأ في الاتصال. يتم عرض البيانات المحلية";
        _isPaused = isPausedError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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

    // Show loading indicator only on first load
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Main content with animations
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: heroUrl != null
                            ? NetworkImage(heroUrl) as ImageProvider
                            : AssetImage(MyPhoto),
                        backgroundColor: theme.colorScheme.background,
                      ),
                      const SizedBox(height: 24),

                      // الاسم
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // التخصص
                      Text(
                        role,
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
                          shortBio,
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

          // // Error message banner (if any)
          // if (_error != null)
          //   Positioned(
          //     top: 20,
          //     left: 20,
          //     right: 20,
          //     child: FadeInUp(
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //         decoration: BoxDecoration(
          //           color: _isPaused ? Colors.orange : Colors.red,
          //           borderRadius: BorderRadius.circular(12),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(0.1),
          //               blurRadius: 10,
          //               offset: const Offset(0, 2),
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           children: [
          //             Icon(
          //               _isPaused ? Icons.pause_circle_outline : Icons.error_outline,
          //               color: Colors.white,
          //               size: 24,
          //             ),
          //             const SizedBox(width: 12),
          //             Expanded(
          //               child: Text(
          //                 _error!,
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
          //               onPressed: _loadHome,
          //               tooltip: 'إعادة المحاولة',
          //             ),
          //             IconButton(
          //               icon: const Icon(Icons.close, color: Colors.white, size: 20),
          //               onPressed: () {
          //                 setState(() {
          //                   _error = null;
          //                 });
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}