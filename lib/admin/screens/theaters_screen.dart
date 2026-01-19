import 'package:flutter/material.dart';

class TheatersScreen extends StatelessWidget {
  const TheatersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách rạp")),
      backgroundColor: Colors.grey[900],
      body: const Center(
        child: Text("Quản lý rạp (placeholder)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
