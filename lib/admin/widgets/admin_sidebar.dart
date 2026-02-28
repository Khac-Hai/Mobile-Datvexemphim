import 'package:datvexemphim/admin/screens/promo_screen.dart';
import 'package:datvexemphim/admin/screens/voucher_screen.dart';
import 'package:flutter/material.dart';
import '../screens/movies_screen.dart';
import '../screens/theaters_screen.dart';
import '../screens/users_screen.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            const DrawerHeader(
              child: Text(
                "Nguyễn Khắc Hải",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            _item(context, "List Movie", Icons.movie, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MoviesScreen()));
            }),
            _item(context, "List Theater", Icons.theaters, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TheatersScreen()));
            }),
            _item(context, "List Voucher", Icons.card_giftcard, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const VoucherScreen()));
            }),
            _item(context, "List Promo", Icons.local_offer, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PromoAdminScreen()));
            }),
            _item(context, "User Account", Icons.person, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UsersScreen()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
