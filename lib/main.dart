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
