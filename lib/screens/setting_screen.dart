import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logout.dart';
import 'profile_screen.dart';
import 'points_policy_screen.dart';
import 'vecuatoi.dart';
import 'phimdaxem.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final fullName = user?.displayName ?? "Thành viên";
    final greetingName = fullName;
    final photoURL = user?.photoURL ??
        "https://i.pinimg.com/736x/d8/6c/f3/d86cf339d4baed9fb0ebfa9b83f3e61e.jpg";

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white, // 🎨 Giống CustomMenu
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
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
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "Xin chào $greetingName",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        onPressed: () {
                          showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // ---------- Các mục menu ----------
                  _buildMenuItem(
                    Icons.movie,
                    "Phim đã xem",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WatchedMoviesScreen(),
                        ),
                      );
                    },
                  ),

                  _buildMenuItem(
                    Icons.confirmation_num,
                    "Vé của tôi",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyTicketsScreen(),
                        ),
                      );
                    },
                  ),

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

                  const Spacer(),

                  // ---------- Phiên bản ----------
                  const Center(
                    child: Text(
                      "Phiên bản: 1.0.0+1",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget tạo item menu
  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.red, size: 26),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
