import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_portfolio/core/utils/theme_provider.dart';
import '../models/project_detail_model.dart';
import '../widgets/project_details_header.dart';
import '../widgets/project_image_slider.dart';
import '../widgets/project_about_section.dart';
import '../widgets/project_features_section.dart';
import '../widgets/project_technologies_section.dart';
import '../widgets/github_button.dart';

class ProjectDetailPage extends StatefulWidget {
  final String projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final supabase = Supabase.instance.client;
  bool _loading = true;
  String? _error;
  ProjectDetailModel? project;

  final _uuidRegExp = RegExp(
      r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$');

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  Future<void> _loadProject() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final rawId = widget.projectId.trim();
      final query = supabase
          .from('projects')
          .select('*, project_images(id, image_url, position)');

      final res = _uuidRegExp.hasMatch(rawId)
          ? await query.eq('id', rawId).maybeSingle()
          : await query.eq('slug', rawId).maybeSingle();

      if (res == null || res is! Map) {
        setState(() {
          _error = 'Project not found';
          _loading = false;
        });
        return;
      }

      project = ProjectDetailModel.fromMap(Map<String, dynamic>.from(res));
    } catch (e) {
      _error = e.toString();
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(body: Center(child: Text("Error: $_error")));
    }
    if (project == null) {
      return const Scaffold(body: Center(child: Text("Project not found")));
    }

    final p = project!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: FadeInDown(
          child: Text(
            p.title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: isDarkMode ? Colors.white : Colors.black87,
              size: 22,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // RefreshIndicator(
          //   onRefresh: _loadProject,
          //   child:
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: ProjectDetailsHeader(
                    category: p.category,
                    title: p.title,
                    description: p.description,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: ProjectImageSlider(images: p.images),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child:
                      ProjectAboutSection(longDescription: p.longDescription),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 900),
                  child: ProjectFeaturesSection(features: p.features),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child:
                      ProjectTechnologiesSection(technologies: p.technologies),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // ),
          // GitHub floating button with animation
          Positioned(
            bottom: 20,
            right: 20,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: GithubButton(githubUrl: p.githubUrl),
            ),
          ),
        ],
      ),
    );
  }
}
