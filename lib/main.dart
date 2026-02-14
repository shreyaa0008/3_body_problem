import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'navigation/bottom_nav.dart';

void main() {
  runApp(FinQuestApp());
}

class FinQuestApp extends StatelessWidget {
  const FinQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BottomNav(),
    );
  }
}
