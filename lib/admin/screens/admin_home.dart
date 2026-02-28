import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../admin/widgets/admin_sidebar.dart';
import '../../admin/screens/movies_screen.dart';
import '../../admin/screens/theaters_screen.dart';
import '../../admin/screens/voucher_screen.dart';
import '../../admin/screens/promo_screen.dart';
import '../../admin/screens/users_screen.dart'; // thêm import

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  Future<int> _getCount(String collection) async {
    final snapshot = await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.size;
  }

  Future<int> _getCinemaCount() async {
    final snapshot = await FirebaseFirestore.instance.collection("regions").get();
    int total = 0;
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final cinemas = List<String>.from(data["cinemas"] ?? []);
      total += cinemas.length;
    }
    return total;
  }

  Widget _statCard(String title, int value) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              "$value",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Quản lý phim", "icon": Icons.movie, "screen": const MoviesScreen()},
      {"title": "Quản lý rạp", "icon": Icons.theaters, "screen": const TheatersScreen()},
      {"title": "Quản lý voucher", "icon": Icons.card_giftcard, "screen": const VoucherScreen()},
      {"title": "Quản lý khuyến mãi", "icon": Icons.local_offer, "screen": const PromoAdminScreen()},
      {"title": "Quản lý tài khoản", "icon": Icons.person, "screen": const UsersScreen()}, // thêm mục này
    ];

    return Scaffold(
      drawer: const AdminSidebar(),
      appBar: AppBar(
        title: const Text("Trang chủ Admin"),
        backgroundColor: Colors.red.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<int>>(
              future: Future.wait([
                _getCount("movies"),
                _getCinemaCount(),
                _getCount("vouchers"),
                _getCount("promotions"),
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final counts = snapshot.data!;
                return Row(
                  children: [
                    Expanded(child: _statCard("Phim", counts[0])),
                    Expanded(child: _statCard("Rạp", counts[1])),
                    Expanded(child: _statCard("Voucher", counts[2])),
                    Expanded(child: _statCard("Khuyến mãi", counts[3])),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Menu quản lý
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => item["screen"] as Widget));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item["icon"] as IconData, size: 48, color: Colors.red.shade700),
                        const SizedBox(height: 12),
                        Text(item["title"] as String,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
