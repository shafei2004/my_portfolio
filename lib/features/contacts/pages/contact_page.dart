import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/scroll_appearance.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/contacts/controllers/contact_controller.dart';
import 'package:my_portfolio/features/contacts/models/contact_data.dart';
import 'package:my_portfolio/features/contacts/widgets/contact_form_section.dart';
import 'package:my_portfolio/features/contacts/widgets/contact_info_section.dart';
import 'package:my_portfolio/features/contacts/widgets/social_links_row.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _controller = ContactController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _loading = true;
  ContactData? _contactData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _controller.fetchContactData();
    setState(() {
      _contactData = data;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final data = _contactData ??
        ContactData(
          email: 'mohamedalielshafei7@gmail.com',
          phone: '+201144704545',
          location: 'Minia, Egypt',
          socialLinks: [
            {
              "name": "linkedin",
              "href": "https://www.linkedin.com/in/mohamed-el-shafei-62baba25a"
            },
            {"name": "github", "href": "https://github.com/shafei2004"},
            {"name": "whatsapp", "href": "https://wa.me/201144704545"},
          ],
        );

    final contactInfo = [
      {"icon": Icons.email_rounded, "label": "Email", "value": data.email},
      {"icon": Icons.phone_android_rounded, "label": "Phone", "value": data.phone},
      {"icon": Icons.location_on_rounded, "label": "Location", "value": data.location},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header Section
              ScrollAppearance(
                delay: const Duration(milliseconds: 200),
                offset: const Offset(0, -0.2), // Slide down
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Me",
                      style: GoogleFonts.cairo(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onBackground,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 80,
                      height: 5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.5)],
                        ),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Have a project in mind or just want to chat? Feel free to reach out and let's build something amazing together.",
                      style: GoogleFonts.cairo(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 64),

              // 🔹 Main Content (Split view on web/desktop, stacked on mobile)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 850;

                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: _buildInfoColumn(data, contactInfo, colorScheme),
                            ),
                            const SizedBox(width: 64),
                            Expanded(
                              flex: 6,
                              child: ScrollAppearance(
                                delay: const Duration(milliseconds: 600),
                                offset: const Offset(0.2, 0), // Slide from right
                                child: ContactFormSection(
                                  formKey: _formKey,
                                  nameController: _nameController,
                                  emailController: _emailController,
                                  messageController: _messageController,
                                  recipientEmail: data.email,
                                  controller: _controller,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildInfoColumn(data, contactInfo, colorScheme),
                            const SizedBox(height: 48),
                            ScrollAppearance(
                              delay: const Duration(milliseconds: 400),
                              offset: const Offset(0, 0.2),
                              child: ContactFormSection(
                                formKey: _formKey,
                                nameController: _nameController,
                                emailController: _emailController,
                                messageController: _messageController,
                                recipientEmail: data.email,
                                controller: _controller,
                              ),
                            ),

                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildInfoColumn(ContactData data, List<Map<String, dynamic>> contactInfo, ColorScheme colorScheme) {
    return ScrollAppearance(
      delay: const Duration(milliseconds: 400),
      offset: const Offset(0, 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ContactInfoSection(contactInfo: contactInfo),
          const SizedBox(height: 32),
          Text(
            "Connect with me",
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          SocialLinksRow(
            links: data.socialLinks,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
