import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/app_router.dart';
import 'package:my_portfolio/core/utils/theme_provider.dart';
import 'package:my_portfolio/core/utils/navigation_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://icutvdqrfgmpmxmxvahy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljdXR2ZHFyZmdtcG14bXh2YWh5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM0Mzg2NTYsImV4cCI6MjA4OTAxNDY1Nn0.brGuminegEcttbWvzIsP2TVXujzrdnFv0OkXwgKXHfE',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
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
      title: 'elshafei.dev',
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // 🌞 Light Theme - Refined
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF312E81),
          brightness: Brightness.light,
          primary: const Color(0xFF312E81),
          surface: const Color(0xFFF8FAFC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // 🌚 Dark Theme - Premium & Modern
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00F0FF), // Neon Cyan
          secondary: Color(0xFF7C3AED), // Vibrant Purple
          surface: Color(0xFF151A22), // Deep Navy Surface
          background: Color(0xFF0A0F1C), // Deepest Navy
          onBackground: Color(0xFFE2E8F0),
          onSurface: Color(0xFF94A3B8),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0F1C),
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme).copyWith(
          displaySmall: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE2E8F0),
          ),
          titleLarge: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00F0FF),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF151A22),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: const Color(0xFF1E293B).withOpacity(0.5),
              width: 1,
            ),
          ),
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
