import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/scroll_appearance.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_model.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final supabase = Supabase.instance.client;
  bool _loading = true;
  List<ProjectModel> projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() => _loading = true);
    try {
      final res = await supabase
          .from('projects')
          .select('id, slug, title, short_description, description, cover_url, features, tools, created_at')
          .eq('is_published', true)
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (res is List) {
        setState(() {
          projects = (res as List<dynamic>)
              .map((e) => ProjectModel.fromMap(Map<String, dynamic>.from(e)))
              .toList();
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint('loadProjects error: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header
            ScrollAppearance(
              delay: const Duration(milliseconds: 200),
              offset: const Offset(-0.2, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My Projects",
                      style: theme.textTheme.displayMedium
                          ?.copyWith(fontWeight: FontWeight.w900, color: colorScheme.onBackground)),
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
                  Text(
                    "A showcase of some of my best work and side projects.",
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 18),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 64),

            // 🔹 Projects List
            _loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : projects.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Column(
                            children: [
                              Icon(Icons.work_outline_rounded,
                                  size: 48, color: colorScheme.onSurface.withOpacity(0.3)),
                              const SizedBox(height: 16),
                              Text(
                                "No projects found yet",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 900;
                          final crossAxisCount = isWide ? 2 : 1;

                          return Column(
                            children: List.generate((projects.length / crossAxisCount).ceil(), (rowIndex) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(crossAxisCount, (colIndex) {
                                  final index = rowIndex * crossAxisCount + colIndex;
                                  if (index >= projects.length) {
                                    return isWide ? const Expanded(child: SizedBox()) : const SizedBox();
                                  }

                                  return Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: (isWide && colIndex == 0) ? 24 : 0,
                                        bottom: 24,
                                      ),
                                      child: ScrollAppearance(
                                        delay: Duration(milliseconds: 200 * index),
                                        offset: const Offset(0, 0.2),
                                        child: ProjectCard(project: projects[index], isDark: theme.brightness == Brightness.dark),
                                      ),
                                    ),
                                  );

                                }),
                              );
                            }),
                          );
                        },
                      ),
          ],
        ),
      );

  }
}
