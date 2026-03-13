import 'package:flutter/material.dart';
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

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  final _controller = ContactController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _loading = true;
  ContactData? _contactData;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _controller.fetchContactData();
    setState(() {
      _contactData = data;
      _loading = false;
    });

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      {"icon": Icons.email, "label": "Email", "value": data.email},
      {"icon": Icons.phone, "label": "Phone", "value": data.phone},
      {"icon": Icons.location_on, "label": "Location", "value": data.location},
    ];

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_fadeController, _slideController]),
        builder: (context, _) {
          return FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: LayoutBuilder(
                key: const ValueKey('contact_layout'),
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                          children: [
                            const Text(
                              "Get In Touch",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Have a project in mind or just want to chat? Feel free to reach out!",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(height: 40),

                            // بدل Wrap إلى Row/Column ثابتين
                            Flex(
                              direction:
                                  isWide ? Axis.horizontal : Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: isWide ? 1 : 0,
                                  child: Column(
                                    children: [
                                      ContactInfoSection(
                                          contactInfo: contactInfo),
                                      const SizedBox(height: 20),
                                      SocialLinksRow(
                                        links: data.socialLinks,
                                        controller: _controller,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width: isWide ? 40 : 0,
                                    height: isWide ? 0 : 40),
                                Expanded(
                                  flex: isWide ? 1 : 0,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
