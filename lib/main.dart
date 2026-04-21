import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MovieTimeApp());
}

class MovieTimeApp extends StatelessWidget {
  const MovieTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Time',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        primaryColor: Colors.orange,
      ),
      home: const SplashScreen(),
    );
  }
}