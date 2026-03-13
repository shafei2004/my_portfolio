// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../models/project_model.dart';
// import '../widgets/project_card.dart';

// class ProjectsPage extends StatefulWidget {
//   const ProjectsPage({super.key});

//   @override
//   State<ProjectsPage> createState() => _ProjectsPageState();
// }

// class _ProjectsPageState extends State<ProjectsPage> {
//   final supabase = Supabase.instance.client;
//   bool _loading = true;
//   String? _error;
//   List<ProjectModel> projects = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadProjects();
//   }

//   Future<void> _loadProjects() async {
//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     try {
//       final res = await supabase
//           .from('projects')
//           .select(
//               'id, slug, title, short_description, description, cover_url, features, created_at')
//           .eq('is_published', true)
//           .order('created_at', ascending: false);

//       if (res == null) throw Exception("No data returned");
//       if (res is! List) throw Exception("Unexpected response format");

//       setState(() {
//         projects = (res as List<dynamic>)
//             .map((e) => ProjectModel.fromMap(Map<String, dynamic>.from(e)))
//             .toList();
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     if (_error != null) return Scaffold(body: Center(child: Text("Failed to load: $_error")));

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: RefreshIndicator(
//         onRefresh: _loadProjects,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               FadeInDown(
//                 child: Text(
//                   "My Projects",
//                   style: GoogleFonts.poppins(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: theme.textTheme.bodyMedium?.color,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               FadeInUp(
//                 child: Text(
//                   "Here are some of the projects I have worked on...",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   double cardWidth = (constraints.maxWidth - 40) / 2;
//                   if (constraints.maxWidth < 700) cardWidth = constraints.maxWidth;

//                   return Wrap(
//                     spacing: 20,
//                     runSpacing: 20,
//                     alignment: WrapAlignment.center,
//                     children: projects
//                         .map((p) => SizedBox(
//                               width: cardWidth,
//                               child: ProjectCard(project: p, isDark: isDark),
//                             ))
//                         .toList(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
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
  String? _error;
  bool _isPaused = false;
  List<ProjectModel> projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() {
      _loading = true;
      _error = null;
      _isPaused = false;
    });

    try {
      final res = await supabase
          .from('projects')
          .select(
              'id, slug, title, short_description, description, cover_url, features, created_at')
          .eq('is_published', true)
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10)); // Add timeout

      if (res == null) throw Exception("No data returned");
      if (res is! List) throw Exception("Unexpected response format");

      setState(() {
        projects = (res as List<dynamic>)
            .map((e) => ProjectModel.fromMap(Map<String, dynamic>.from(e)))
            .toList();
        _loading = false;
      });
    } catch (e) {
      String errorMessage = e.toString();
      bool isPausedError = errorMessage.contains('paused') || 
                           errorMessage.contains('timeout') ||
                           errorMessage.contains('connection') ||
                           errorMessage.contains('Failed host lookup');

      setState(() {
        _error = isPausedError 
            ? "المشروع متوقف حالياً. يرجى المحاولة لاحقاً"
            : "حدث خطأ في تحميل المشاريع";
        _isPaused = isPausedError;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _loadProjects,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                child: Text(
                  "My Projects",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                child: Text(
                  "Here are some of the projects I have worked on...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              if (_error != null) ...[
                FadeInUp(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _isPaused 
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isPaused 
                            ? Colors.orange
                            : Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _isPaused ? Icons.pause_circle_outline : Icons.error_outline,
                          size: 48,
                          color: _isPaused ? Colors.orange : Colors.red,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: _isPaused ? Colors.orange : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _loadProjects,
                          icon: const Icon(Icons.refresh),
                          label: const Text("حاول مرة أخرى"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isPaused ? Colors.orange : Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (projects.isEmpty) ...[
                FadeInUp(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.folder_open,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "لا توجد مشاريع متاحة حالياً",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                LayoutBuilder(
                  builder: (context, constraints) {
                    double cardWidth = (constraints.maxWidth - 40) / 2;
                    if (constraints.maxWidth < 700) cardWidth = constraints.maxWidth;

                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: projects
                          .map((p) => SizedBox(
                                width: cardWidth,
                                child: ProjectCard(project: p, isDark: isDark),
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}