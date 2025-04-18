// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';

// class ProjectsPage extends StatelessWidget {
//   const ProjectsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final gradientColors = isDarkMode
//         ? [
//             const Color.fromARGB(255, 0, 7, 79),
//             Colors.black87
//           ] // Dark Mode (already good)
//         : [Colors.blue.shade900, Colors.blue];
//     return Stack(
//       children: [
//         // Background gradient effect
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: gradientColors,
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         SingleChildScrollView(
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
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               FadeInUp(
//                 child: Text(
//                   "Here are some of the projects I have worked on. Each project showcases my skills in Flutter development, UI/UX design, and backend integration.",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, color: Colors.grey[300]),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               _buildBlogPostList(context),
//               // const SizedBox(height: 30),
//               // FadeInUp(
//               //   delay: const Duration(milliseconds: 800),
//               //   child: ElevatedButton(
//               //     onPressed: () {},
//               //     style: ElevatedButton.styleFrom(
//               //       padding: const EdgeInsets.symmetric(
//               //           horizontal: 30, vertical: 12),
//               //       backgroundColor:
//               //           Theme.of(context).brightness == Brightness.dark
//               //               ? const Color.fromARGB(
//               //                   255, 0, 7, 79) // Dark Mode Button
//               //               : Colors.blue.shade900, // Light Mode Button
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(8),
//               //       ),
//               //     ),
//               //     child: Text(
//               //       "View More Projects",
//               //       style: GoogleFonts.poppins(
//               //         fontSize: 16,
//               //         color: Colors.white,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBlogPostList(BuildContext context) {
//     List<Map<String, String>> blogPosts = [
//       {
//         "title": "My portfolio",
//         "description": "This portfolio website was built using Flutter.",
//         "imagePath": 'assets/images/portfolio 1.png'
//       },
//       {
//         "title": "Bookly app",
//         "description": "Mobile app to search for books and buy them.",
//         "imagePath": 'assets/images/bookly 1.png'
//       },
//       {
//         "title": "Queue system app",
//         "description":
//             "Mobile app to simulate a queuing system for a bank.",
//         "imagePath": 'assets/images/simulation 1.jpg'
//       },
//       {
//         "title": "تطبيق الاذكار",
//         "description": "تطبيق اسلامى يعرض الاذكار الاساسيه فى الحياه اليوميه",
//         "imagePath": 'assets/images/azkar 1.jpg'
//       },
//       {
//         "title": "Weather app",
//         "description": "Mobile app to check the weather around the world.",
//         "imagePath": 'assets/images/weather 1.jpg'
//       },
//       {
//         "title": 'Chat app',
//         "description": 'Mobile app to chat with friends.',
//         "imagePath": 'assets/images/chat 1.jpg'
//       },
//       {
//         "title": 'Notes app',
//         "description": 'Mobile app to take notes and organize them.',
//         "imagePath": 'assets/images/notes 1.jpg'
//       },
//     ];

//     return Column(
//       children:
//           blogPosts.map((post) => _buildBlogPostItem(context, post)).toList(),
//     );
//   }

//   Widget _buildBlogPostItem(BuildContext context, Map<String, String> post) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return FadeInUp(
//       delay: const Duration(milliseconds: 500),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isDarkMode
//               ? const Color.fromARGB(255, 0, 7, 79)
//               : Colors.blue.shade900,
//           borderRadius: BorderRadius.circular(12),
// boxShadow: [
//   BoxShadow(
//     color: isDarkMode ? Colors.black54 : Colors.blueGrey.shade400,
//     blurRadius: 8,
//     spreadRadius: 2,
//     offset: const Offset(0, 4),
//   ),
// ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 post["imagePath"]!,
//                 height: 120,
//                 width: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     post["title"]!,
//                     style: GoogleFonts.poppins(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     post["description"]!,
//                     style: GoogleFonts.poppins(
//                         fontSize: 14, color: Colors.grey[300]),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Icon(Icons.chevron_right, size: 50, color: Colors.white,),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:my_portfolio/models/project_details_model.dart';
import 'package:my_portfolio/pages/projects_details_page.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [
            const Color.fromARGB(255, 0, 7, 79),
            Colors.black87,
          ]
        : [Colors.blue.shade900, Colors.blue];

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient effect
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
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
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  child: Text(
                    "Here are some of the projects I have worked on. Each project showcases my skills in Flutter development, UI/UX design.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildProjectList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList(BuildContext context) {
    List<Project> projects = [
      Project(
        title: "My Portfolio",
        description: "This portfolio website built using Flutter.",
        mainImagePath: 'assets/images/portfolio 1.png',
        additionalImagePaths: [
          'assets/images/portfolio 2.png',
          'assets/images/portfolio 3.png',
          'assets/images/portfolio 4.png',
          'assets/images/portfolio 5.png',
          'assets/images/portfolio app 1.png',
          'assets/images/portfolio app 2.png',
          'assets/images/portfolio app 3.png',
          'assets/images/portfolio app 4.png',
          'assets/images/portfolio app 5.png',
        ],
        longDescription:
            "A responsive portfolio website built with Flutter Web to showcase my skills and projects.",
        features: [
          "Responsive design for all screen sizes",
          "Dark/Light mode toggle",
          "Animated transitions between pages",
          "Project showcase with details"
        ],
        technologiesUsed: "Flutter, Dart, Animate_Do",
        githubLink: "https://github.com/shafei2004/my_portfolio.git",
      ),
      Project(
        title: "Bookly App",
        description: "Books search app.",
        mainImagePath: 'assets/images/bookly 1.png',
        additionalImagePaths: [
          'assets/images/bookly 2.png',
          'assets/images/bookly 3.png',
        ],
        longDescription: "A responsive book search app built with Flutter and Dart.",
        features: [
          "Book search with filters",
          "Shopping cart system",
        ],
        technologiesUsed: "Flutter, Dart, MVVM, API",
        githubLink: "https://github.com/shafei2004/bookly_app.git",
      ),
      Project(
        title: "Queue system app",
        description: "simulate a queuing system.",
        mainImagePath: 'assets/images/simulation 1.jpg',
        additionalImagePaths: [
          'assets/images/simulation 2.jpg',
          'assets/images/simulation 3.jpg',
          'assets/images/simulation 4.jpg',
          'assets/images/simulation 5.jpg',
          'assets/images/simulation 6.jpg',
        ],
        longDescription: "simulate a queuing system for a bank or hospital.",
        features: [
          "simulation for a queuig system",
          "upload data file or add it manually.",
          'use one server or two servers.',
          'display taple and graphs to explain the process.'
              'save the new data in new file.',
          'clean all data to start again.',
        ],
        technologiesUsed: "Flutter, Dart, fl_chart, file_picker, path_provider",
        githubLink: "https://github.com/shafei2004/queuing_system.git",
      ),
      Project(
        title: "تطبيق الاذكار",
        description: "تطبيق اسلامى يعرض الاذكار",
        mainImagePath: 'assets/images/azkar 1.jpg',
        additionalImagePaths: [
          'assets/images/azkar 2.jpg',
          'assets/images/azkar 3.jpg',
        ],
        longDescription:
            "التطبيق يعرض الاذكار الاساسيه فى حياتنا اليوميه ويساعد على تذكرها، كما يوجد به سبحه الكترونيه.",
        features: [
          "السبحه",
          "اذكار الاستيقاظ",
          "اذكار الصباح",
          "اذكار (خروج ودخول) المنزل",
          'الذكر قبل وبعد الوضوء',
          'اذكار الذهاب للمسجد',
          'الاذكار بعد الصلاة',
          'اذكار المساء',
          'اذكار قبل النوم',
          'دعاء صلاة الاستخارة',
          'دعاء الهمَ والحزن',
          'دعاء الكرب',
          'دعاء السفر',
        ],
        technologiesUsed: "Flutter, Dart",
      ),
      Project(
        title: "Chat app",
        description: "Simple chating app.",
        mainImagePath: 'assets/images/chat 1.jpg',
        additionalImagePaths: [
          'assets/images/chat 2.jpg',
          'assets/images/chat 3.jpg',
          'assets/images/chat 4.jpg',
        ],
        longDescription:
            "A simple app that allows you to communicate with family and friends easily.",
        features: [
          'You can register a new account by email.',
          'log in directly if you have an account in the app.',
          'text chat with friends and family.',
        ],
        technologiesUsed:
            "Flutter, Dart, firebase , authentication, firestore databases",
        githubLink: "https://github.com/shafei2004/chat_app.git",
      ),
      Project(
        title: "Notes app",
        description: "Simple notes app.",
        mainImagePath: 'assets/images/notes 1.jpg',
        additionalImagePaths: [
          'assets/images/notes 2.jpg',
          'assets/images/notes 3.jpg',
          'assets/images/notes 4.jpg',
        ],
        longDescription:
            "A simple application that allows you to write, edit and manage your notes in general.",
        features: [
          'write your notes.',
          'you can edit your notes.',
          'you can choose the color of every note.',
        ],
        technologiesUsed: "Flutter, Dart, bloc & cubit, hive database",
        githubLink: "https://github.com/shafei2004/notes_app.git",
      ),
      Project(
        title: "Weather app",
        description: "Mobile app to check the weather.",
        mainImagePath: 'assets/images/weather 4.jpg',
        additionalImagePaths: [
          'assets/images/weather 2.jpg',
          'assets/images/weather 3.jpg',
          'assets/images/weather 1.jpg',
          'assets/images/weather 5.jpg',
          'assets/images/weather 6.jpg',
        ],
        longDescription:
            "A simple application that allows you to check the weather of any country or city in the world by searching for it.",
        features: [
          'You can search for weather using city name.',
          'The app display ( average temperature, max temperature, mini temperature, weather description and photo that describes the weather.',
        ],
        technologiesUsed: "Flutter, Dart, API",
        githubLink: "https://github.com/shafei2004/weather_app.git",
      ),
    ];

    return Column(
      children: projects
          .map((project) => _buildProjectItem(context, project))
          .toList(),
    );
  }

  Widget _buildProjectItem(BuildContext context, Project project) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color.fromARGB(255, 0, 7, 79)
              : Colors.blue.shade900,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.blueGrey.shade400,
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        // elevation: 4,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(12),
        // ),
        // color: isDarkMode
        //     ? const Color.fromARGB(255, 0, 7, 79)
        //     : Colors.blue.shade900,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _navigateToProjectDetails(context, project),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: project.mainImagePath,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      project.mainImagePath,
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 120,
                        width: 80,
                        color: Colors.grey[800],
                        child:
                            const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        project.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: project.features
                            .take(2)
                            .map((feature) => Chip(
                                  label: Text(
                                    feature,
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.blue[800],
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, size: 30, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToProjectDetails(BuildContext context, Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailsPage(project: project),
      ),
    );
  }
}
