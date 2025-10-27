import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'setting/profile_screen.dart';
import 'setting/change_password_screen.dart';
import 'setting/wallet_screen.dart';
import 'setting/giftcard_screen.dart';
import 'setting/history_screen.dart';
import 'setting/coupon_screen.dart';
import 'setting/help_center_screen.dart';
import 'setting/about_app_screen.dart';
import 'package:datvexemphim/screens/logout_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    setState(() {
      name = doc.data()?['name'] ?? user.displayName ?? "Người dùng CGV";
      email = user.email ?? "Chưa có email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Tài khoản của tôi"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Thông tin người dùng ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=5"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? "Đang tải...",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email ?? "Đang tải...",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Thành viên CGV Regular",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- Nhóm 1: Hồ sơ cá nhân ---
          _buildSectionTitle("Tài khoản & Hồ sơ"),
          _buildListTile(
            icon: Icons.person_outline,
            title: "Chỉnh sửa hồ sơ",
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
              // 🔁 Reload lại sau khi chỉnh sửa
              _loadUserData();
            },
          ),
          _buildListTile(
            icon: Icons.lock_outline,
            title: "Đổi mật khẩu",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),

          const SizedBox(height: 24),

          // --- Nhóm 2: Ví & Thanh toán ---
          _buildSectionTitle("Ví & Thanh toán"),
          _buildListTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "Ví CGV Pay",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WalletScreen()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.card_giftcard_outlined,
            title: "Thẻ quà tặng",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GiftCardScreen()),
              );
            },
          ),

          const SizedBox(height: 24),

          // --- Nhóm 3: Lịch sử & Ưu đãi ---
          _buildSectionTitle("Lịch sử & Ưu đãi"),
          _buildListTile(
            icon: Icons.history_outlined,
            title: "Lịch sử đặt vé",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.local_offer_outlined,
            title: "Mã giảm giá của tôi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CouponScreen()),
              );
            },
          ),

          const SizedBox(height: 24),

          // --- Nhóm 4: Hỗ trợ & Khác ---
          _buildSectionTitle("Hỗ trợ & Khác"),
          _buildListTile(
            icon: Icons.help_outline,
            title: "Trung tâm hỗ trợ",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.info_outline,
            title: "Giới thiệu ứng dụng",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutAppScreen()),
              );
            },
          ),

          const SizedBox(height: 24),

          // --- Đăng xuất ---
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Đăng xuất",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LogoutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Tiêu đề nhóm
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Tạo từng dòng chức năng
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
