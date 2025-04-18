import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
        alignment: Alignment.center,
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
                    "Get in Touch",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                FadeInUp(
                  child: Text(
                    "Feel free to reach out for collaborations, projects, or just to say hi!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildContactInfoSection(context),
                const SizedBox(height: 30),
                _buildSocialIconsSection(context),
                const SizedBox(height: 30),
                _buildEmailButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactItem(
              Icons.email,
              "Email",
              "mohamedalielshafei7@gmail.com",
              onTap: () => _launchEmail("mohamedalielshafei7@gmail.com", context),
            ),
            _buildContactItem(
              Icons.phone,
              "Phone",
              "+20 114 470 4545",
              onTap: () => _launchPhone("+201144704545", context),
            ),
            _buildContactItem(
              Icons.location_on,
              "Location",
              "Minia, Egypt",
              onTap: () => _launchMaps("Minia, Egypt", context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 1000),
      child: ElevatedButton(
        onPressed: () => _launchEmail("mohamedalielshafei7@gmail.com", context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 0, 7, 79)
              : Colors.blue.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Send Email",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String info,
      {VoidCallback? onTap}) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.white),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    info,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIconsSection(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 800),
      child: Column(
        children: [
          Text(
            "Connect with me on:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                context,
                FontAwesomeIcons.linkedin,
                // Icons.linked_camera,
                "LinkedIn",
                "https://www.linkedin.com/in/mohamed-el-shafei-62baba25a",
              ),
              const SizedBox(width: 20),
              _buildSocialIcon(
                context,
                FontAwesomeIcons.github,
                // Icons.code,
                "GitHub",
                "https://github.com/shafei2004",
              ),
              const SizedBox(width: 20),
              _buildSocialIcon(
                context,
                FontAwesomeIcons.whatsapp,
                // Icons.phone,
                "WhatsApp",
                "https://wa.me/201144704545",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(
      BuildContext context, IconData icon, String tooltip, String url) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: FaIcon(icon, size: 28, color: Colors.white),
        onPressed: () => _launchURL(context, url),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to open link: $e');
    }
  }

  Future<void> _launchEmail(String email, BuildContext context) async {
    try {
      final uri = Uri.parse('mailto:$email');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to open email: $e');
    }
  }

  Future<void> _launchPhone(String phone, BuildContext context) async {
    try {
      final uri = Uri.parse('tel:$phone');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch phone';
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to open phone: $e');
    }
  }

  Future<void> _launchMaps(String location, BuildContext context) async {
    try {
      final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch maps';
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to open maps: $e');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}