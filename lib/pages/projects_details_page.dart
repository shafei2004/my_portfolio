import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/models/project_details_model.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode 
        ? const Color.fromARGB(255, 0, 7, 79)
        : Colors.blue.shade900;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main project image with hero animation
            Hero(
              tag: project.mainImagePath,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: Image.asset(
                    project.mainImagePath,
                    width: 300,
                    height: 600,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Project description
            Text(
              project.longDescription,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),

            // Technologies used
            _buildSectionTitle('Technologies Used'),
            Text(
              project.technologiesUsed,
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // Features
            _buildSectionTitle('Key Features'),
            Column(
              children: project.features
                  .map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[300],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Screenshots
            if (project.additionalImagePaths.isNotEmpty) ...[
              _buildSectionTitle('Screenshots'),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: project.additionalImagePaths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          project.additionalImagePaths[index],
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 120,
                            color: Colors.grey[800],
                            child: const Icon(Icons.broken_image,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
      floatingActionButton: project.githubLink != null
          ? FloatingActionButton.extended(
              onPressed: () => _launchGitHubLink(context, project.githubLink!),
              icon: const Icon(Icons.code, color: Colors.white),
              label: Text(
                'View Code',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blue[800],
            )
          : null,
    );
  }

  Future<void> _launchGitHubLink(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to open GitHub: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_portfolio/models/project_details_model.dart';

// class ProjectDetailsPage extends StatelessWidget {
//   final Project project;

//   const ProjectDetailsPage({super.key, required this.project});

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final bgColor =
//         isDarkMode ? const Color.fromARGB(255, 0, 7, 79) : Colors.blue.shade900;

//     return Scaffold(
//       backgroundColor: bgColor,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.transparent,
//       //   elevation: 0,
//       //   title: Text(
//       //     project.title,
//       //     style: GoogleFonts.poppins(color: Colors.white),
//       //   ),
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back, color: Colors.white),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       // ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Main project image with hero animation
//             Hero(
//               tag: project.mainImagePath,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Center(
//                   child: Image.asset(
//                     project.mainImagePath,
//                     width: 300,
//                     height: 600,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       height: 200,
//                       color: Colors.grey[800],
//                       child: const Center(
//                         child: Icon(Icons.broken_image,
//                             color: Colors.white, size: 50),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Project description
//             Text(
//               project.longDescription,
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 color: Colors.grey[300],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Technologies used
//             _buildSectionTitle('Technologies Used'),
//             Text(
//               project.technologiesUsed,
//               style: GoogleFonts.poppins(
//                 color: Colors.grey[300],
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Features
//             _buildSectionTitle('Key Features'),
//             Column(
//               children: project.features
//                   .map((feature) => Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Icon(Icons.check_circle,
//                                 color: Colors.green, size: 16),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 feature,
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.grey[300],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ))
//                   .toList(),
//             ),
//             const SizedBox(height: 20),

//             // Screenshots
//             if (project.additionalImagePaths.isNotEmpty) ...[
//               _buildSectionTitle('Screenshots'),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 150,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: project.additionalImagePaths.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           project.additionalImagePaths[index],
//                           width: 120,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Container(
//                             width: 120,
//                             color: Colors.grey[800],
//                             child: const Icon(Icons.broken_image,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ],
//         ),
//       ),
//       floatingActionButton: project.githubLink != null
//           ? FloatingActionButton.extended(
//               onPressed: () {
//                 // TODO: Implement URL launching
//                 // You can use url_launcher package
//               },
//               icon: const Icon(Icons.code, color: Colors.white),
//               label: Text(
//                 'View Code',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                 ),
//               ),
//               backgroundColor: Colors.blue[800],
//             )
//           : null,
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.poppins(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//     );
//   }
// }
