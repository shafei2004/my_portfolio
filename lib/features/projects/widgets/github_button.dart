import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubButton extends StatelessWidget {
  final String githubUrl;
  const GithubButton({super.key, required this.githubUrl});

  Future<void> _openUrl(BuildContext context, String url) async {
    if (url.trim().isEmpty) return;
    Uri uri = Uri.parse(url.startsWith("http") ? url : "https://$url");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Could not open URL.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (githubUrl.isEmpty) return const SizedBox.shrink();

    return ElevatedButton.icon(
      onPressed: () => _openUrl(context, githubUrl),
      icon: const Icon(Icons.code),
      label: const Text("View on GitHub"),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
      ),
    );
  }
}
