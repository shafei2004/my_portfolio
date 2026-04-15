import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: colorScheme.background,
        border: Border(
          top: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          
          // 🛡️ Copyright
          Text(
            "© 2026 Mohamed El-Shafei. All rights reserved.",
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface.withOpacity(0.3),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

  }
}
