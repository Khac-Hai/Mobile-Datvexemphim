import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Giả định các file này đã tồn tại trong project của bạn
import 'logout.dart';
import 'profile_screen.dart';
import 'points_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin người dùng từ Firebase
    final user = FirebaseAuth.instance.currentUser;
    // Lấy tên đầy đủ, nếu null thì mặc định là "Thành viên"
    final fullName = user?.displayName ?? "Thành viên";

    // Loai bo logic tách tên. Chỉ sử dụng fullName
    final greetingName = fullName;

    // Loại bỏ hoàn toàn remainingName
    // final remainingName = '';

    final photoURL = user?.photoURL ??
        "https://s.yimg.com/fz/api/res/1.2/4JjhjiP9K5uJbpoqv._6ZA--~C/YXBwaWQ9c3JjaGRkO2ZpPWZpbGw7aD00MTI7cHhvZmY9NTA7cHlvZmY9MTAwO3E9ODA7c3M9MTt3PTM4OA--/https://i.pinimg.com/736x/d8/6c/f3/d86cf339d4baed9fb0ebfa9b83f3e61e.jpg";

    return Scaffold(
      // Quan trọng: Đặt nền Scaffold là trong suốt để không cản trở showGeneralDialog
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.centerRight,
        child: Container(
          // Chiếm toàn bộ chiều cao và 90% chiều ngang (hoặc 70% nếu bạn thích)
          width: MediaQuery.of(context).size.width * 0.9,
          height: double.infinity,
          decoration: BoxDecoration(
            // Đảm bảo màu nền là MÀU ĐEN MỜ ĐỤC (opacity 1.0) để che màn hình Home
            color: Colors.black.withOpacity(1.0),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Thông tin người dùng ----------
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(photoURL),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Normal",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            // Hiển thị "Xin chào" và tên đầy đủ trên MỘT DÒNG
                            Text(
                              "Xin chào $greetingName",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            // Đã loại bỏ dòng hiển thị tên thứ hai (remainingName)
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        onPressed: () {
                          showLogoutDialog(context); // Thêm hàm này vào file logout.dart của bạn

                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // ---------- Các mục menu ----------
                  _buildMenuItem(Icons.movie, "Phim đã xem"),
                  _buildMenuItem(Icons.confirmation_num, "Vé của tôi"),

                  _buildMenuItem(
                    Icons.person,
                    "Thông tin thành viên",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),

                  _buildMenuItem(
                      Icons.card_giftcard,
                      "Chính sách tích điểm",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PointsPolicyScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
