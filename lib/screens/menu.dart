import 'package:datvexemphim/services/chonphim.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datvexemphim/services/cinema_screen.dart';
import 'package:datvexemphim/services/gift_screen.dart';
import 'package:datvexemphim/services/promo_screen.dart';
import '../services/chonphim.dart';
import 'contact_screen.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧭 Danh sách các mục chính
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                children: [
                  _buildMenuItem(Icons.movie, "Mua vé", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CinemaScreen()),
                    );
                  }),
                  const Divider(),

                  _buildMenuItem(Icons.local_movies_outlined, "Phim", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChonPhim(selectedCinema: "Tất cả rạp"),
                      ),
                    );
                  }),

                  const Divider(),

                  _buildMenuItem(Icons.theaters, "Rạp", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CinemaScreen()),
                    );
                  }),
                  const Divider(),

                  _buildMenuItem(Icons.local_offer, "Khuyến mãi", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GiftScreen()),
                    );
                  }),
                  const Divider(),

                  _buildMenuItem(Icons.card_giftcard, "Quà tặng", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PromoScreen()),
                    );
                  }),
                  const Divider(),

                  // 👉 Liên hệ
                  _buildMenuItem(Icons.support_agent, "Liên hệ", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactScreen()),
                    );
                  }),
                  const Divider(),

                  // 🌐 Mạng xã hội — Đặt ngay dưới "Liên hệ"
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Kết nối với chúng tôi",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      FaIcon(FontAwesomeIcons.facebook, color: Colors.blue, size: 28),
                      FaIcon(FontAwesomeIcons.tiktok, color: Colors.black, size: 28),
                      FaIcon(FontAwesomeIcons.youtube, color: Colors.red, size: 28),
                      FaIcon(FontAwesomeIcons.commentDots, color: Colors.blueAccent, size: 28),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // 🔢 Phiên bản + nút ngôn ngữ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Phiên bản: 1.0.0+1", style: TextStyle(fontSize: 12)),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text("VIE", style: TextStyle(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("ENG", style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📍 Hàm tạo item menu
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
