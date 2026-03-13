import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/app_router.dart';
import 'package:my_portfolio/core/utils/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://cazydzpculbiotpzxofq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhenlkenBjdWxiaW90cHp4b2ZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAzNDU0MjAsImV4cCI6MjA3NTkyMTQyMH0.YpP9S3NdS_3Wdpu5zlfh531Zwe9tSPVowiN-bdilZJQ',
  );
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

    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // 🌞 Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFF8F8F8), // Off-White
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),

      // 🌚 Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF121212),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1E1E1E), // أفتح شوية من 121212
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1F1F1F), // لون مناسب للكروت في الوضع الليلي
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}



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
//         primaryColor: Colors.blue.shade900,
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.grey[900],
//         primaryColor: const Color.fromARGB(255, 0, 7, 79),
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

//     final appBarColor = isDarkMode
//         ? const Color.fromARGB(255, 0, 7, 79) // Dark Mode Top Bar
//         : Colors.blue.shade900; // Light Mode Top Bar

//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             decoration: BoxDecoration(
//               color: appBarColor.withOpacity(0.95),
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
//                       _buildNavItem(Icons.home, "Home", 0, isDarkMode),
//                       _buildNavItem(Icons.person, "About", 1, isDarkMode),
//                       _buildNavItem(Icons.work, "Projects", 2, isDarkMode),
//                       // _buildNavItem(Icons.article, "Blog", 3, isDarkMode),
//                       _buildNavItem(
//                           Icons.contact_mail, "Contact", 3, isDarkMode),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           isDarkMode ? Icons.dark_mode : Icons.light_mode,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                         onPressed: () => themeProvider.toggleTheme(),
//                       ),
//                       Text(
//                         isDarkMode ? "Dark Mode" : "Light Mode",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           // fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
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

//   Widget _buildNavItem(
//       IconData icon, String label, int index, bool isDarkMode) {
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
//               color: isSelected
//                   ? Colors.white
//                   : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
//               size: 24,
//             ),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 color: isSelected
//                     ? Colors.white
//                     : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
