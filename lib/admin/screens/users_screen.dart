import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tài khoản người dùng")),
      backgroundColor: Colors.grey[900],
      body: const Center(
        child: Text("Quản lý người dùng (placeholder)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
