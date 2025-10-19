import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trung tâm hỗ trợ"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Nếu bạn gặp sự cố trong quá trình đặt vé,\n"
              "vui lòng liên hệ tổng đài CGV: 1900 6017\n"
              "hoặc email: cskh@cgv.vn",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
