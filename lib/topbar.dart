import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/theme_provider.dart';
import 'package:my_portfolio/features/about/pages/about_page.dart';
import 'package:my_portfolio/features/contacts/pages/contact_page.dart';
import 'package:my_portfolio/features/home/pages/home_page.dart';
import 'package:my_portfolio/features/projects/pages/projects_page.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const AboutPage(),
    ProjectsPage(),
    const ContactPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// ⬅️ Navigation Titles
                  Row(
                    children: [
                      _buildNavItem("Home", 0, isDarkMode),
                      _buildNavItem("About", 1, isDarkMode),
                      _buildNavItem("Projects", 2, isDarkMode),
                      _buildNavItem("Contact", 3, isDarkMode),
                    ],
                  ),

                  /// 🌞/🌙 Theme toggle on the right
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: isDarkMode ? Colors.white : Colors.black87,
                      size: 24,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                ],
              ),
            ),
          ),

          /// 🔽 Page content
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index, bool isDarkMode) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? (isDarkMode ? Colors.cyanAccent : Colors.teal)
                : (isDarkMode ? Colors.grey[400] : Colors.black87),
          ),
        ),
      ),
    );
  }
}
