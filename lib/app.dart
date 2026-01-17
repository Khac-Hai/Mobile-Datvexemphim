import 'package:flutter/material.dart';
import 'customer/core/theme.dart';
import 'auth/login_screen_cus.dart';


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