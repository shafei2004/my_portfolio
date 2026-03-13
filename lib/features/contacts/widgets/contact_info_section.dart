import 'package:flutter/material.dart';

class ContactInfoSection extends StatelessWidget {
  final List<Map<String, dynamic>> contactInfo;

  const ContactInfoSection({super.key, required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: contactInfo.map((item) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceVariant.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(item["icon"], color: theme.colorScheme.primary),
            title: Text(item["value"]),
            subtitle: Text(item["label"]),
          ),
        );
      }).toList(),
    );
  }
}
