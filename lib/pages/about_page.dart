// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';

// class AboutPage extends StatelessWidget {
//   const AboutPage({super.key});

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
//                   "About Me",
//                   style: GoogleFonts.poppins(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               FadeInUp(
//                 child: Text(
//                   "I am a passionate Flutter Developer with expertise in crafting cross-platform applications. With experience in mobile and web development, I focus on creating scalable, performant, and visually appealing apps.",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, color: Colors.grey[300]),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Divider(color: Colors.grey[500]),
//               const SizedBox(height: 20),

//               // Skills Section
//               FadeInUp(
//                 delay: const Duration(milliseconds: 200),
//                 child: Text(
//                   "Skills & Expertise",
//                   style: GoogleFonts.poppins(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               FadeInUp(
//                 delay: const Duration(milliseconds: 400),
//                 child: Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: [
//                     _buildSkillChip("Flutter"),
//                     _buildSkillChip("Dart"),
//                     _buildSkillChip("Firebase"),
//                     _buildSkillChip("REST API"),
//                     _buildSkillChip("UI/UX Design"),
//                     _buildSkillChip("State Management"),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Experience Section
//               FadeInUp(
//                 delay: const Duration(milliseconds: 600),
//                 child: Text(
//                   "Experience",
//                   style: GoogleFonts.poppins(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               _buildExperienceItem("Flutter Developer",
//                   "Developing high-quality mobile and web applications using Flutter."),
//               // _buildExperienceItem("Mobile App Developer Intern",
//               //     "Assisted in developing mobile applications with Flutter."),
//               const SizedBox(height: 30),

//               // Call to Action
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
//                             : Colors.blue.shade900,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     "Download Resume",
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

//   Widget _buildSkillChip(String label) {
//     return Chip(
//       label: Text(
//         label,
//         style: GoogleFonts.poppins(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//       backgroundColor: Colors.blueGrey[600],
//     );
//   }

//   Widget _buildExperienceItem(
//     String title,
//     // String duration,
//     String description,
//   ) {
//     return FadeInUp(
//       delay: const Duration(milliseconds: 500),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             // Text(
//             //   duration,
//             //   style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[300]),
//             // ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//               child: Text(
//                 description,
//                 textAlign: TextAlign.center,
//                 style:
//                     GoogleFonts.poppins(fontSize: 14, color: Colors.grey[400]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [const Color.fromARGB(255, 0, 7, 79), Colors.black87]
        : [Colors.blue.shade900, Colors.blue];

    return Stack(
      children: [
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
                  "About Me",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '''Hi, I’m Mohamed El-Shafei — a Flutter developer who builds beautiful and scalable applications for mobile, web, and beyond. I specialize in crafting smooth user experiences with high performance and clean code architecture.

I started my journey in app development with a strong passion for creating digital tools that are not just functional, but elegant and intuitive. I’ve worked on various projects applying concepts like MVVM, Clean Architecture, and state management patterns along the way.

As I continue to grow in Flutter and mobile development, I’m preparing to explore the field of Artificial Intelligence — aiming to merge it with my work in the future.''',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Divider(color: Colors.grey[500]),
              const SizedBox(height: 30),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Text(
                  "Skills & Expertise",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 1000),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildSkillChip("Flutter"),
                    _buildSkillChip("Dart"),
                    _buildSkillChip("Firebase"),
                    _buildSkillChip("REST API"),
                    _buildSkillChip("SQLite"),
                    _buildSkillChip("MVVM"),
                    _buildSkillChip("Clean Architecture"),
                    _buildSkillChip("UI/UX Design"),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 1200),
                child: Text(
                  "Experience",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildExperienceItem(
                title: 'Education',
                description:
                    '''- Faculty of computer and information , Minia University
- Department of computer science''',
              ),
              _buildExperienceItem(
                title: "Mobile app Developer",
                description:
                    '''- Built and maintained multiple mobile and web applications using Flutter, implementing modern design patterns and clean code practices.
- Collaborated with cross-functional teams to deliver high-quality solutions.
- Implemented state management solutions, including Provider and BLoC.
- Conducted code reviews and provided constructive feedback to fellow developers.
- Developed and implemented UI/UX design solutions for mobile and web applications.
- Utilized Firebase for backend services and data management.''',
              ),
              // const SizedBox(height: 30),
              // FadeInUp(
              //   delay: const Duration(milliseconds: 1400),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 30, vertical: 12),
              //       backgroundColor: isDarkMode
              //           ? const Color.fromARGB(255, 0, 7, 79)
              //           : Colors.blue.shade900,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: Text(
              //       "Download Resume",
              //       style: GoogleFonts.poppins(
              //         fontSize: 16,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueGrey[600],
    );
  }

  Widget _buildExperienceItem({
    required String title,
    required String description,
  }) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                description,
                // textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
