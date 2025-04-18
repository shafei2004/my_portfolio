// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_portfolio/pages/about_page.dart';
// import 'package:my_portfolio/pages/blog_page.dart';
// import 'package:my_portfolio/pages/contact_page.dart';
// import 'package:my_portfolio/pages/home_pages.dart';
// import 'package:my_portfolio/pages/projects_page.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//         scaffoldBackgroundColor: Colors.grey[100],
//         primaryColor: Colors.blueGrey[900],
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.grey[900],
//         primaryColor: Colors.blueGrey[700],
//       ),
//       themeMode: themeProvider.themeMode,
//       home: const PortfolioPage(),
//     );
//   }
// }

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.light;

//   ThemeMode get themeMode => _themeMode;

//   void toggleTheme() {
//     _themeMode =
//         (_themeMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
//     notifyListeners();
//   }
// }

// class PortfolioPage extends StatefulWidget {
//   const PortfolioPage({super.key});

//   @override
//   _PortfolioPageState createState() => _PortfolioPageState();
// }

// class _PortfolioPageState extends State<PortfolioPage> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     const HomePage(),
//     const AboutPage(),
//     const ProjectsPage(),
//     const BlogPage(),
//     const ContactPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
//     final appBarColor =
//         isDarkMode ? Colors.blueGrey[800] : Colors.blueGrey[900];

//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             decoration: BoxDecoration(
//               color: appBarColor?.withOpacity(0.95),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 12,
//                   spreadRadius: 2,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       _buildNavItem(Icons.home, "Home", 0),
//                       _buildNavItem(Icons.person, "About", 1),
//                       _buildNavItem(Icons.work, "Projects", 2),
//                       _buildNavItem(Icons.article, "Blog", 3),
//                       _buildNavItem(Icons.contact_mail, "Contact", 4),
//                     ],
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       isDarkMode ? Icons.dark_mode : Icons.light_mode,
//                       color: Colors.white,
//                     ),
//                     onPressed: () => themeProvider.toggleTheme(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: _pages[_selectedIndex],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? Colors.white : Colors.grey[400],
//               size: 24,
//             ),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 color: isSelected ? Colors.white : Colors.grey[400],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/pages/about_page.dart';
import 'package:my_portfolio/pages/blog_page.dart';
import 'package:my_portfolio/pages/contact_page.dart';
import 'package:my_portfolio/pages/home_pages.dart';
import 'package:my_portfolio/pages/projects_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
        primaryColor: Colors.blue.shade900,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColor: const Color.fromARGB(255, 0, 7, 79),
      ),
      themeMode: themeProvider.themeMode,
      home: const PortfolioPage(),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        (_themeMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const AboutPage(),
    // const ProjectsPage(),
    const ProjectsPage(),
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
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    final appBarColor = isDarkMode
        ? const Color.fromARGB(255, 0, 7, 79) // Dark Mode Top Bar
        : Colors.blue.shade900; // Light Mode Top Bar

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: appBarColor.withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildNavItem(Icons.home, "Home", 0, isDarkMode),
                      _buildNavItem(Icons.person, "About", 1, isDarkMode),
                      _buildNavItem(Icons.work, "Projects", 2, isDarkMode),
                      // _buildNavItem(Icons.article, "Blog", 3, isDarkMode),
                      _buildNavItem(
                          Icons.contact_mail, "Contact", 3, isDarkMode),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => themeProvider.toggleTheme(),
                      ),
                      Text(
                        isDarkMode ? "Dark Mode" : "Light Mode",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, int index, bool isDarkMode) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
              size: 24,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
