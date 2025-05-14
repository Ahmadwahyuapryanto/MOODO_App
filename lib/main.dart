import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MoodoApp());
}

class MoodoApp extends StatefulWidget {
  const MoodoApp({super.key});

  @override
  State<MoodoApp> createState() => _MoodoAppState();
}

class _MoodoAppState extends State<MoodoApp> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOODO',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: MoodoHomePage(
        isDarkMode: _isDarkMode,
        onToggleTheme: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
    );
  }
}