import 'package:flutter/material.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý thành phố")),
      backgroundColor: Colors.grey[900],
      body: const Center(
        child: Text("Quản lý thành phố (placeholder)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
