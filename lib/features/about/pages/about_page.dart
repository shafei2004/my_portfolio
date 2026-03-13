import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_portfolio/features/about/widgets/build_card.dart';
import 'package:my_portfolio/features/about/widgets/online_courses.dart';
import 'package:my_portfolio/features/about/widgets/section_title.dart';
import 'package:my_portfolio/features/about/widgets/skill_card.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  final supabase = Supabase.instance.client;

  bool _loading = true;
  String _aboutDescription = '';
  List<Map<String, dynamic>> education = [];
  List<Map<String, dynamic>> experience = [];
  List<String> onlineCourses = [];
  List<Map<String, dynamic>> skills = [];

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _loadAbout();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _loadAbout() async {
    try {
      final response = await supabase
          .from('about')
          .select('sections')
          .limit(1)
          .maybeSingle();

      if (response == null) {
        setState(() => _loading = false);
        _fadeController.forward();
        _slideController.forward();
        return;
      }

      final sections = response['sections'] as Map<String, dynamic>?;
      if (sections == null) {
        setState(() => _loading = false);
        _fadeController.forward();
        _slideController.forward();
        return;
      }

      final aboutMe = sections['about_me'] as Map<String, dynamic>?;
      final aboutDesc =
          aboutMe != null ? (aboutMe['description'] ?? '') as String : '';

      final eduList = (sections['education'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [];
      final expList = (sections['experience'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [];
      final oc = sections['online_courses'];
      List<String> online = [];
      if (oc is List) {
        online = oc.map((e) => e.toString()).toList();
      } else if (oc is String) {
        online = oc
            .split('\n')
            .map((e) => e.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }

      final skillsList = (sections['skills'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [];

      setState(() {
        _aboutDescription = aboutDesc;
        education = eduList;
        experience = expList;
        onlineCourses = online;
        skills = skillsList;
        _loading = false;
      });

      _fadeController.forward();
      _slideController.forward();
    } catch (e, st) {
      debugPrint('Failed to load about: $e\n$st');
      setState(() => _loading = false);
      _fadeController.forward();
      _slideController.forward();
    }
  }

  IconData _iconFromString(dynamic iconValue) {
    // iconValue ممكن يكون IconData بالفعل، أو String مثل "Icons.code" أو "code" أو "Code"
    if (iconValue == null) return Icons.star;

    if (iconValue is IconData) return iconValue;

    final s = iconValue.toString().trim();

    // نظّف القيمة لو جاية بشكل "Icons.code" أو "IconData(U+0...)" أو بس "code"
    String key = s;
    if (key.startsWith('Icons.')) {
      key = key.substring('Icons.'.length);
    }
    key = key.toLowerCase();

    switch (key) {
      case 'code':
      case 'icons.code':
        return Icons.code;
      case 'people':
      case 'icons.people':
        return Icons.people;
      case 'school':
      case 'icons.school':
        return Icons.school;
      case 'work':
      case 'icons.work':
        return Icons.work;
      case 'star':
      case 'icons.star':
        return Icons.star;
      case 'build':
      case 'icons.build':
        return Icons.build;
      case 'design':
      case 'icons.design_services':
      case 'design_services':
        return Icons.design_services;
      case 'language':
        return Icons.language;
      case 'devices':
        return Icons.devices;
      default:
        // لو القيمة عبارة عن اسم أيقونة غير مذكور فوق حاول خريطة بسيطة إضافية
        final fallbackMap = <String, IconData>{
          'github': Icons.code,
          'dev': Icons.developer_mode,
        };
        return fallbackMap[key] ?? Icons.star;
    }
  }

  // 👇 widget helper لتطبيق الأنيميشن على أي Card
  Widget _animatedCard(int index, Widget child) {
    final delay = index * 0.1; // تأخير بسيط بين الكروت
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, _) {
        final opacity = Curves.easeInOut
            .transform((_fadeController.value - delay).clamp(0.0, 1.0));
        final slide = (1 - opacity) * 20;
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, slide),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔹 عنوان الصفحة
                Column(
                  children: [
                    Text("About Me",
                        style: theme.textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        _aboutDescription.isNotEmpty
                            ? _aboutDescription
                            : 'Flutter developer passionate about building reliable mobile applications with clean UI and seamless integration.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color:
                                theme.colorScheme.onSurface.withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // 🔹 Education
                SectionTitle(icon: Icons.school, title: 'Education'),
                const SizedBox(height: 16),
                Column(
                  children: (education.isNotEmpty
                          ? education
                          : [
                              {
                                "degree": "Faculty of Computer and Information",
                                "institution": "Minia University",
                                "year": "Expected Graduation: 2026",
                                "description": "Department of Computer Science"
                              }
                            ])
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _animatedCard(
                              entry.key,
                              BuildCard(
                                title: entry.value["degree"] ?? '',
                                subtitle: entry.value["institution"] ?? '',
                                year: entry.value["year"] ?? '',
                                description: entry.value["description"] ?? '',
                              ),
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 40),

                // 🔹 Online Courses
                SectionTitle(
                    icon: Icons.school, title: 'Online Courses & Training'),
                const SizedBox(height: 16),
                _animatedCard(
                  0,
                  OnlineCourses(
                    title: onlineCourses.isNotEmpty
                        ? onlineCourses.join('\n')
                        : '''Flutter & Dart Complete Development 
State Management (MVVM) 
Clean Architecture for Scalable Applications''',
                  ),
                ),

                const SizedBox(height: 40),

                // 🔹 Experience
                SectionTitle(icon: Icons.work, title: "Experience"),
                const SizedBox(height: 16),
                Column(
                  children: (experience.isNotEmpty
                          ? experience
                          : [
                              {
                                "title": "Mobile Application Developer",
                                "company": "Self-Learning",
                                "year": "2023 - Present",
                                "description":
                                    "Designed and developed multiple mobile applications using Flutter and Dart, focusing on both UI and application logic."
                              }
                            ])
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _animatedCard(
                              entry.key,
                              BuildCard(
                                title: entry.value["title"] ?? '',
                                subtitle: entry.value["company"] ?? '',
                                year: entry.value["year"] ?? '',
                                description: entry.value["description"] ?? '',
                              ),
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 40),

                // 🔹 Skills
                SectionTitle(icon: Icons.star, title: "Skills & Expertise"),
                const SizedBox(height: 16),
                Wrap(
                  children: (skills.isNotEmpty
                          ? skills
                          : [
                              {
                                'name': 'Technical Skills',
                                'icon': Icons.code,
                                'items': [
                                  'Dart & Flutter',
                                  'Clean UI Design',
                                  'State Management',
                                  'Clean Architecture (MVVM)',
                                  'APIs',
                                  'Firebase',
                                  'Supabase',
                                  'Git & GitHub'
                                ]
                              },
                              {
                                'name': 'Soft Skills',
                                'icon': Icons.people,
                                'items': [
                                  'Problem-solving',
                                  'Time management',
                                  'Teamwork',
                                  'Communication',
                                  'Continuous learning'
                                ]
                              }
                            ])
                      .asMap()
                      .entries
                      .map((entry) {
                    // here convert icon value (could be IconData or String) to IconData
                    final rawIcon = entry.value['icon'];
                    final iconData = _iconFromString(rawIcon);
                    // ensure items is a List<String> or List<dynamic>
                    final itemsRaw = entry.value['items'];
                    final itemsList = (itemsRaw is List)
                        ? itemsRaw.map((e) => e.toString()).toList()
                        : <String>[];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _animatedCard(
                        entry.key,
                        SkillCard(skill: {
                          'name': entry.value['name'] ?? '',
                          'icon': iconData,
                          'items': itemsList,
                        }),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
