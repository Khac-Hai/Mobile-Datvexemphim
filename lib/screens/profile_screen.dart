import 'package:datvexemphim/screens/setting/delete_account_screen.dart';
import 'package:datvexemphim/screens/setting/profile_screen.dart';
import 'package:flutter/material.dart';
import 'setting/profile_screen.dart';
import 'setting/change_password_screen.dart';
import 'setting/delete_account_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildMenuItem(
            context,
            'lib/assets/icons/iconprofile.png', // 👉 Thay hình tương ứng
            'Thay đổi thông tin thành viên',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen1(),
                    ),
                  );
            },
          ),
          _buildMenuItem(
            context,
            'lib/assets/icons/iconprofile.png', // 👉 Thay hình tương ứng
            'Đổi mật khẩu',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
            },
          ),
          _buildMenuItem(
            context,
            'lib/assets/icons/iconprofile.png', // 👉 Thay hình tương ứng
            'Xoá tài khoản',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccountScreen(),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String imagePath, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
