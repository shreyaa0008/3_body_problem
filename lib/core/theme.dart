import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFF5F6FA),
    primaryColor: Color(0xFF6C63FF),
    fontFamily: 'Poppins',
    cardColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Color(0xFF8F94FB),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black54,
        fontSize: 16,
      ),
    ),
  );
}
