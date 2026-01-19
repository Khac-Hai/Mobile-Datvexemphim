import 'package:flutter/material.dart';

class ShowtimesScreen extends StatelessWidget {
  const ShowtimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Suất chiếu")),
      backgroundColor: Colors.grey[900],
      body: const Center(
        child: Text("Quản lý suất chiếu (placeholder)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
