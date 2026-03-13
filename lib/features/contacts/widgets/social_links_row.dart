import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/contact_controller.dart';

class SocialLinksRow extends StatelessWidget {
  final List<Map<String, dynamic>> links;
  final ContactController controller;

  const SocialLinksRow({
    super.key,
    required this.links,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: links.map((link) {
        final href = link['href']?.toString();
        final name = (link['name'] ?? '').toString().toLowerCase();
        IconData iconData = FontAwesomeIcons.question;
        if (name.contains('linkedin'))
          iconData = FontAwesomeIcons.linkedin;
        else if (name.contains('github'))
          iconData = FontAwesomeIcons.github;
        else if (name.contains('whatsapp'))
          iconData = FontAwesomeIcons.whatsapp;

        return IconButton(
          onPressed: () => controller.launchURL(href),
          icon: Icon(iconData, size: 30, color: theme.colorScheme.primary),
        );
      }).toList(),
    );
  }
}
