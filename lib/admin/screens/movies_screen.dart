import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách phim")),
      backgroundColor: Colors.grey[900],
      body: const Center(
        child: Text("Quản lý phim (placeholder)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
