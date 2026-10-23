import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/home_page.dart';
import 'pages/builder_page.dart';
import 'pages/templates_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/privacy_page.dart';
import 'pages/terms_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CvStudioApp());
}

class CvStudioApp extends StatefulWidget {
  const CvStudioApp({super.key});

  @override
  State<CvStudioApp> createState() => _CvStudioAppState();
}

class _CvStudioAppState extends State<CvStudioApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      title: 'CV Studio — Professional Online Resume Builder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _themeMode,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = HomePage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          case '/builder':
            page = BuilderPage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          case '/templates':
            page = TemplatesPage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          case '/about':
            page = AboutPage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          case '/contact':
            page = ContactPage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          case '/privacy':
            page = PrivacyPage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          case '/terms':
            page = TermsPage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
          default:
            page = HomePage(onToggleTheme: _toggleTheme, isDark: isDark);
            break;
        }

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          settings: settings,
        );
      },
    );
  }
}
