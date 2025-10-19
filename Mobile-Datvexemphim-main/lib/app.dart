import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/login_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Booking',
      theme: AppTheme.light(),
      home: const LoginScreen(),
    );
  }
}