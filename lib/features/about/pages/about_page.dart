import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/visibility_animator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_portfolio/features/about/widgets/build_card.dart';
import 'package:my_portfolio/features/about/widgets/section_title.dart';
import 'package:my_portfolio/features/about/widgets/skill_card.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final supabase = Supabase.instance.client;

  bool _loading = true;
  String _aboutDescription = '';
  List<Map<String, dynamic>> education = [];
  List<Map<String, dynamic>> experience = [];
  List<String> onlineCourses = [];
  List<Map<String, dynamic>> skills = [];

  @override
  void initState() {
    super.initState();
    _loadAbout();
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
        return;
      }

      final sections = response['sections'] as Map<String, dynamic>?;
      if (sections == null) {
        setState(() => _loading = false);
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
    } catch (e, st) {
      debugPrint('Failed to load about: $e\n$st');
      setState(() => _loading = false);
    }
  }

  IconData _iconFromString(dynamic iconValue) {
    if (iconValue == null) return Icons.star;
    if (iconValue is IconData) return iconValue;
    final s = iconValue.toString().trim();
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
        final fallbackMap = <String, IconData>{
          'github': Icons.code,
          'dev': Icons.developer_mode,
        };
        return fallbackMap[key] ?? Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1000;
        final horizontalPadding = isDesktop ? constraints.maxWidth * 0.1 : 24.0;

        return VisibilityAnimator(
          threshold: 0.15,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 About Me Header
              FadeInLeft(
                duration: const Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About Me",
                        style: theme.textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.w900, color: colorScheme.onBackground, fontSize: isDesktop ? 48 : 32)),
                    const SizedBox(height: 16),
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isDesktop ? 900 : double.infinity),
                      child: Text(
                        _aboutDescription.isNotEmpty
                            ? _aboutDescription
                            : 'Flutter developer passionate about building reliable mobile applications with clean UI and seamless integration.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.7),
                            height: 1.6,
                            fontSize: isDesktop ? 20 : 18),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              if (isDesktop)
                // 🖥️ Desktop: Side-by-Side Education & Experience
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(Icons.school_rounded, 'Education'),
                          const SizedBox(height: 32),
                          ..._buildEducationList(education),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(Icons.work_rounded, 'Experience'),
                          const SizedBox(height: 32),
                          ..._buildExperienceList(experience),
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                // 📱 Mobile: Stacked Education & Experience
                _buildSectionTitle(Icons.school_rounded, 'Education'),
                const SizedBox(height: 24),
                ..._buildEducationList(education),
                const SizedBox(height: 48),
                _buildSectionTitle(Icons.work_rounded, 'Experience'),
                const SizedBox(height: 24),
                ..._buildExperienceList(experience),
              ],

              const SizedBox(height: 80),

              // 🔹 Skills Section
              _buildSectionTitle(Icons.bolt_rounded, "Skills & Expertise"),
              const SizedBox(height: 32),
              if (isDesktop)
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: _buildSkillsList(skills).map((w) => SizedBox(width: (constraints.maxWidth * 0.8 - 48) / 2, child: w)).toList(),
                )
              else
                Column(children: _buildSkillsList(skills)),
            ],
          ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: SectionTitle(icon: icon, title: title),
    );
  }

  List<Widget> _buildEducationList(List<Map<String, dynamic>> data) {
    final list = data.isNotEmpty ? data : [
      {
        "degree": "Faculty of Computer and Information",
        "institution": "Minia University",
        "year": "Expected Graduation: 2026",
        "description": "Department of Computer Science"
      }
    ];
    return list.asMap().entries.map((entry) => _buildTimelineEntry(
      index: entry.key,
      total: list.length,
      child: BuildCard(
        title: entry.value["degree"] ?? '',
        subtitle: entry.value["institution"] ?? '',
        year: entry.value["year"] ?? '',
        description: entry.value["description"] ?? '',
      ),
    )).toList();
  }

  List<Widget> _buildExperienceList(List<Map<String, dynamic>> data) {
    final list = data.isNotEmpty ? data : [
      {
        "title": "Mobile Application Developer",
        "company": "Self-Learning",
        "year": "2023 - Present",
        "description": "Designed and developed multiple mobile applications using Flutter and Dart, focusing on both UI and application logic."
      }
    ];
    return list.asMap().entries.map((entry) => _buildTimelineEntry(
      index: entry.key,
      total: list.length,
      child: BuildCard(
        title: entry.value["title"] ?? '',
        subtitle: entry.value["company"] ?? '',
        year: entry.value["year"] ?? '',
        description: entry.value["description"] ?? '',
      ),
    )).toList();
  }

  Widget _buildTimelineEntry({
    required int index,
    required int total,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isLast = index == total - 1;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📍 Timeline Column
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 24.0),
            child: Column(
              children: [
                // ⏺️ Dot
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(color: colorScheme.background, width: 3),
                  ),
                ),
                // 📏 Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorScheme.primary,
                            colorScheme.primary.withOpacity(0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // 🧩 Card Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: Duration(milliseconds: 100 * index),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> _buildSkillsList(List<Map<String, dynamic>> data) {
    final list = data.isNotEmpty ? data : [
      {
        'name': 'Technical Skills',
        'icon': Icons.code,
        'items': ['Dart & Flutter', 'Clean UI Design', 'State Management', 'Clean Architecture', 'APIs', 'Firebase', 'Supabase', 'Git & GitHub']
      },
      {
        'name': 'Soft Skills',
        'icon': Icons.people,
        'items': ['Problem-solving', 'Time management', 'Teamwork', 'Communication', 'Continuous learning']
      }
    ];
    return list.asMap().entries.map((entry) {
      final rawIcon = entry.value['icon'];
      final iconData = _iconFromString(rawIcon);
      final itemsRaw = entry.value['items'];
      final itemsList = (itemsRaw is List)
          ? itemsRaw.map((e) => e.toString()).toList()
          : <String>[];

      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: Duration(milliseconds: 150 * entry.key),
          child: SkillCard(skill: {
            'name': entry.value['name'] ?? '',
            'icon': iconData,
            'items': itemsList,
          }),
        ),
      );
    }).toList();

  }
}
