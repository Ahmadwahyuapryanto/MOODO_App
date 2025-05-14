import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Inter',
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFE88DB0),
    primaryColor: const Color(0xFF7B57C9),
    iconTheme: const IconThemeData(color: Colors.black),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xFFF48FB1)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 28, color: Colors.black),
      displayMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF424242), height: 1.3), // Dark gray
      bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF424242)), // Dark gray
      titleLarge: TextStyle(fontSize: 18, color: Colors.black),
      labelLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFFF48FB1)),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF424242),
    iconTheme: const IconThemeData(color: Colors.white),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xFF9E9E9E)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 28, color: Colors.white),
      displayMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFBDBDBD), height: 1.3), // Light gray
      bodyMedium: TextStyle(fontSize: 16, color: Color(0xFFBDBDBD)), // Light gray
      titleLarge: TextStyle(fontSize: 18, color: Colors.white),
      labelLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
    ),
  );
}