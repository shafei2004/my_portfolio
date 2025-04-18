import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:my_portfolio/pages/contact_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [const Color.fromARGB(255, 0, 7, 79), Colors.black87]
        : [Colors.blue.shade900, Colors.blue];

    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hero animation for profile picture
                Semantics(
                  label: "Profile picture of Mohamed El-Shafei",
                  child: FadeInDown(
                    child: Hero(
                      tag: 'profile-picture',
                      child: CircleAvatar(
                        radius: 120,
                        backgroundImage: AssetImage(MyPhoto),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Semantics(
                  label: "Name: Mohamed El-Shafei",
                  child: FadeInUp(
                    child: Text(
                      "Mohamed El-Shafei",
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Semantics(
                  label: "Flutter Developer for Mobile and Web",
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      "Flutter Developer | Mobile & Web",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Semantics(
                  label:
                      "Brief description: I build performant and elegant apps using Flutter",
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Software engineer with a passion for Mobile App development using Flutter.", // I specialize in creating high-performance, visually stunning, and user-friendly mobile and web applications.
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Semantics(
                  button: true,
                  label: "Let's Work Together. Navigate to contact page.",
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Let's Work Together",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Colors.white.withOpacity(0.1)
                            : Colors.blue.shade900,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
