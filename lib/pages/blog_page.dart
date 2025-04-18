// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:my_portfolio/constants.dart';

// class ProjectsPage extends StatelessWidget {
//   const ProjectsPage({super.key});

//   final List<Map<String, String>> _projects = const [
//     {
//       "title": "Project One",
//       "description": "A mobile app with Firebase backend and stunning UI.",
//       "imagePath": 'assets/images/Screenshot_1744549113.png',
//       "imagePath2": 'assets/images/Screenshot_1744549119.png',
//       "tech": "Flutter, Firebase, UI/UX"
//     },
//     {
//       "title": "Project Two",
//       "description":
//           "A responsive Flutter web app with complex state management.",
//       "imagePath": test,
//       "imagePath2": test,
//       "tech": "Flutter, Provider, Web"
//     },
//     {
//       "title": "Project Three",
//       "description": "A cross-platform eCommerce application.",
//       "imagePath": test,
//       "imagePath2": test,
//       "tech": "Flutter, SQLite, REST API"
//     },
//     {
//       "title": "Project Three",
//       "description": "A cross-platform eCommerce application.",
//       "imagePath": test,
//       "imagePath2": test,
//       "tech": "Flutter, SQLite, REST API"
//     },
//     {
//       "title": "Project Three",
//       "description": "A cross-platform eCommerce application.",
//       "imagePath": test,
//       "imagePath2": test,
//       "tech": "Flutter, SQLite, REST API"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final gradientColors = isDarkMode
//         ? [const Color.fromARGB(255, 0, 7, 79), Colors.black87]
//         : [Colors.blue.shade900, Colors.blue];

//     return Stack(
//       children: [
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
//             crossAxisAlignment: CrossAxisAlignment.start,
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
//                   "Explore my recent projects showcasing skills in Flutter, UI/UX design, and backend integration.",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.grey[300],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount:
//                       MediaQuery.of(context).size.width > 800 ? 3 : 1,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                   childAspectRatio: .8,
//                 ),
//                 itemCount: _projects.length,
//                 itemBuilder: (context, index) {
//                   final project = _projects[index];
//                   return FadeInUp(
//                     delay: Duration(milliseconds: 200 * index),
//                     child: _buildProjectCard(context, project, isDarkMode),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProjectCard(
//       BuildContext context, Map<String, String> project, bool isDarkMode) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isDarkMode ? Colors.blueGrey[800] : Colors.blue.shade900,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: isDarkMode ? Colors.black54 : Colors.blueGrey.shade400,
//             blurRadius: 8,
//             spreadRadius: 2,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.asset(
//                   project["imagePath"]!,
//                   height: 400,
//                   width: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.asset(
//                   project["imagePath2"]!,
//                   height: 400,
//                   width: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   project["title"]!,
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   project["description"]!,
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: Colors.grey[300],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Tech: ${project["tech"]!}",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: Colors.grey[400],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:my_portfolio/constants.dart';

// class projectPage extends StatelessWidget {
//   const projectPage({super.key});

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
//               const SizedBox(height: 30),
//               FadeInUp(
//                 delay: const Duration(milliseconds: 800),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 12),
//                     backgroundColor:
//                         Theme.of(context).brightness == Brightness.dark
//                             ? const Color.fromARGB(
//                                 255, 0, 7, 79) // Dark Mode Button
//                             : Colors.blue.shade900, // Light Mode Button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     "View More Projects",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBlogPostList(BuildContext context) {
//     List<Map<String, String>> blogPosts = [
//       {
//         "title": "Project One",
//         "description":
//             "A mobile app with Firebase backend and stunning UI.",
//         "imagePath": test
//       },
//       {
//         "title": "Project Two",
//         "description":
//             "A responsive Flutter web app with complex state management.",
//         "imagePath": test
//       },
//       {
//         "title": "Project Three",
//         "description":
//             "A cross-platform eCommerce application.",
//         "imagePath": test
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
//           boxShadow: [
//             BoxShadow(
//               color: isDarkMode ? Colors.black54 : Colors.blueGrey.shade400,
//               blurRadius: 8,
//               spreadRadius: 2,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 post["imagePath"]!,
//                 height: 80,
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
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:my_portfolio/constants.dart';

// class BlogPage extends StatelessWidget {
//   const BlogPage({super.key});

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
//                   "My Blog",
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
//                   "Insights, tutorials, and experiences on Flutter development, UI/UX, and mobile app best practices.",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[300]),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               _buildBlogPostList(context),
//               const SizedBox(height: 30),
//               FadeInUp(
//                 delay: const Duration(milliseconds: 800),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                     backgroundColor: Theme.of(context).brightness == Brightness.dark
//         ? const Color.fromARGB(255, 0, 7, 79) // Dark Mode Button
//         : Colors.blue.shade900, // Light Mode Button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     "Explore More Articles",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget _buildBlogPostList() {
//   //   List<Map<String, String>> blogPosts = [
//   //     {
//   //       "title": "State Management in Flutter",
//   //       "description": "Comparing Provider, Riverpod, and Bloc for effective state management.",
//   //       "imagePath": test
//   //     },
//   //     {
//   //       "title": "Building Responsive Flutter Apps",
//   //       "description": "Key techniques to ensure your apps adapt seamlessly across devices.",
//   //       "imagePath": test
//   //     },
//   //     {
//   //       "title": "Flutter Performance Optimization",
//   //       "description": "Tips and strategies to make your Flutter apps run faster and smoother.",
//   //       "imagePath": test
//   //     },
//   //   ];

//   //   return Column(
//   //     children: blogPosts.map((post) => _buildBlogPostItem(context, post)).toList(),
//   //   );
//   // }

//   Widget _buildBlogPostList(BuildContext context) {
//   List<Map<String, String>> blogPosts = [
//     {
//       "title": "State Management in Flutter",
//       "description": "Comparing Provider, Riverpod, and Bloc for effective state management.",
//       "imagePath": test
//     },
//     {
//       "title": "Building Responsive Flutter Apps",
//       "description": "Key techniques to ensure your apps adapt seamlessly across devices.",
//       "imagePath": test
//     },
//     {
//       "title": "Flutter Performance Optimization",
//       "description": "Tips and strategies to make your Flutter apps run faster and smoother.",
//       "imagePath": test
//     },
//   ];

//   return Column(
//     children: blogPosts.map((post) => _buildBlogPostItem(context, post)).toList(),
//   );
// }



//   // Widget _buildBlogPostItem(Map<String, String> post) {
//   //   return FadeInUp(
//   //     delay: const Duration(milliseconds: 500),
//   //     child: Container(
//   //       margin: const EdgeInsets.symmetric(vertical: 10),
//   //       padding: const EdgeInsets.all(16),
//   //       decoration: BoxDecoration(
//   //         color: Theme.of(context).brightness == Brightness.dark
//   //   ? const Color.fromARGB(255, 0, 7, 79)  // Dark Mode Color
//   //   : Colors.blue.shade900,  // Light Mode Color
//   //         borderRadius: BorderRadius.circular(12),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Theme.of(context).brightness == Brightness.dark
//   //   ? Colors.black54
//   //   : Colors.blueGrey.shade400,
//   //             blurRadius: 8,
//   //             spreadRadius: 2,
//   //             offset: const Offset(0, 4),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Row(
//   //         crossAxisAlignment: CrossAxisAlignment.center,
//   //         children: [
//   //           ClipRRect(
//   //             borderRadius: BorderRadius.circular(8),
//   //             child: Image.asset(
//   //               post["imagePath"]!,
//   //               height: 80,
//   //               width: 80,
//   //               fit: BoxFit.cover,
//   //             ),
//   //           ),
//   //           const SizedBox(width: 15),
//   //           Expanded(
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Text(
//   //                   post["title"]!,
//   //                   style: GoogleFonts.poppins(
//   //                     fontSize: 18,
//   //                     fontWeight: FontWeight.bold,
//   //                     color: Colors.white,
//   //                   ),
//   //                 ),
//   //                 const SizedBox(height: 5),
//   //                 Text(
//   //                   post["description"]!,
//   //                   style: GoogleFonts.poppins(
//   //                     fontSize: 14,
//   //                     color: Colors.grey[300],
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildBlogPostItem(BuildContext context, Map<String, String> post) {
//   final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//   return FadeInUp(
//     delay: const Duration(milliseconds: 500),
//     child: Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: isDarkMode ? const Color.fromARGB(255, 0, 7, 79) : Colors.blue.shade900,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: isDarkMode ? Colors.black54 : Colors.blueGrey.shade400,
//             blurRadius: 8,
//             spreadRadius: 2,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset(
//               post["imagePath"]!,
//               height: 80,
//               width: 80,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post["title"]!,
//                   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   post["description"]!,
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[300]),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }