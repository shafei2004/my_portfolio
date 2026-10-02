import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class GooglePlayButton extends StatelessWidget {
  final String googlePlayUrl;

  const GooglePlayButton({
    super.key,
    required this.googlePlayUrl,
  });

  Future<void> _openUrl(BuildContext context, String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.tryParse(url.startsWith("http") ? url.trim() : "https://${url.trim()}");
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open Google Play link.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (googlePlayUrl.trim().isEmpty) return const SizedBox.shrink();

    return ElevatedButton.icon(
      onPressed: () => _openUrl(context, googlePlayUrl),
      icon: const FaIcon(
        FontAwesomeIcons.googlePlay,
        size: 16,
        color: Colors.white,
      ),
      label: Text(
        "View on Google Play",
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF01875F), // Google Play official emerald green
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
        shadowColor: const Color(0xFF01875F).withValues(alpha: 0.4),
      ),
    );
  }
}
