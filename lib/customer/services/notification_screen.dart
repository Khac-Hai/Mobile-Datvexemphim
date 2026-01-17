//thong bao
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.white), // chữ trắng nổi bật
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'Hiện chưa có thông báo mới.',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
