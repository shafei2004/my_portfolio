import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoSection extends StatelessWidget {
  final List<Map<String, dynamic>> contactInfo;

  const ContactInfoSection({super.key, required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contactInfo.map((item) {
        return _InfoTile(item: item);
      }).toList(),
    );
  }
}

class _InfoTile extends StatefulWidget {
  final Map<String, dynamic> item;
  const _InfoTile({required this.item});

  @override
  State<_InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<_InfoTile> {
  bool _isHovered = false;

  Future<void> _launchAction(BuildContext context) async {
    final label = widget.item["label"] as String;
    final value = widget.item["value"] as String;
    Uri? uri;

    if (label.toLowerCase().contains("email")) {
      uri = Uri.parse("mailto:$value");
    } else if (label.toLowerCase().contains("phone")) {
      uri = Uri.parse("tel:${value.replaceAll(' ', '')}");
    } else if (label.toLowerCase().contains("location")) {
      uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(value)}");
    }

    if (uri != null) {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not open application")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered ? colorScheme.primary.withOpacity(0.05) : colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? colorScheme.primary.withOpacity(0.5) : colorScheme.onSurface.withOpacity(0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? colorScheme.primary.withOpacity(0.1) : Colors.black.withOpacity(0.03),
              blurRadius: _isHovered ? 20 : 10,
              offset: _isHovered ? const Offset(0, 10) : const Offset(0, 5),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _launchAction(context),
          borderRadius: BorderRadius.circular(24),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            leading: AnimatedScale(
              scale: _isHovered ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.item["icon"] as IconData,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),
            ),
            title: Text(
              widget.item["label"] as String,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            subtitle: Text(
              widget.item["value"] as String,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
            trailing: _isHovered 
              ? Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorScheme.primary)
              : null,
          ),
        ),
      ),
    );
  }
}


