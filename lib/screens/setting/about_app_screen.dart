import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giới thiệu ứng dụng"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "CGV Cinema App\nPhiên bản 1.0.0\n\n"
              "Ứng dụng đặt vé xem phim, thanh toán trực tuyến,\n"
              "và tích điểm thành viên nhanh chóng tiện lợi.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
