import 'package:flutter/material.dart';
import 'pages/contact_page.dart';
import 'pages/services_page.dart';
import 'pages/projects_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'widgets/left_navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio Website',
      theme: ThemeData(
        primaryColor: const Color(0xFF6200EE), // Accent color
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFBB86FC),
        scaffoldBackgroundColor: const Color(0xFF202121),
        appBarTheme: const AppBarTheme(color: Color(0xFF202121)),
      ),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: PortfolioHomePage(
        isDarkTheme: isDarkTheme,
        onThemeChanged: () {
          setState(() {
            isDarkTheme = !isDarkTheme;
          });
        },
      ),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDarkTheme;
  final VoidCallback onThemeChanged;

  const PortfolioHomePage({
    required this.isDarkTheme,
    required this.onThemeChanged,
  });

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  String selectedPage = 'Home';

  // Pages Map
  final Map<String, Widget> pages = {
    'Home': HomePage(),
    'About': AboutPage(),
    'Projects': ProjectsPage(),
    'Services': ServicesPage(),
    'Contact': ContactPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Navigation Bar
          LeftNavBar(
            selectedItem: selectedPage,
            onNavItemSelected: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            isDarkTheme: widget.isDarkTheme,
            onThemeChanged: widget.onThemeChanged,
          ),
          // Divider for Separation
          Container(
            width: 1,
            color: widget.isDarkTheme ? Colors.grey[800] : Colors.grey[300],
          ),
          // Main Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: pages[selectedPage],
            ),
          ),
        ],
      ),
    );
  }
}



