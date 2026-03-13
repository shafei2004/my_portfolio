import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_data.dart';

class ContactController {
  final supabase = Supabase.instance.client;

  Future<ContactData?> fetchContactData() async {
    try {
      final res = await supabase
          .from('contacts')
          .select()
          .eq('is_published', true)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (res == null) return null;
      if (res is Map<String, dynamic>) {
        return ContactData.fromMap(res);
      }
    } catch (e) {
      debugPrint('Error loading contact data: $e');
    }
    return null;
  }

  Future<void> launchURL(String? url) async {
    if (url == null || url.trim().isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> sendEmail({
    required BuildContext context,
    required String toEmail,
    required String name,
    required String email,
    required String message,
  }) async {
    final subject = Uri.encodeComponent('New Message from $name');
    final body = Uri.encodeComponent('Name: $name\nEmail: $email\n\n$message');
    final emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: 'subject=$subject&body=$body',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open email app")),
      );
    }
  }
}
