import 'package:flutter/material.dart';
import '../screens/movies_screen.dart';
import '../screens/showtime_screen.dart';
import '../screens/theaters_screen.dart';
import '../screens/cities_screen.dart';
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
              child: Text("Henry Klein",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            _item(context, "Dashboard", Icons.dashboard, () {
              Navigator.pop(context);
            }),
            _item(context, "List Movie", Icons.movie, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MoviesScreen()));
            }),
            _item(context, "Showtimes", Icons.schedule, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ShowtimesScreen()));
            }),
            _item(context, "List Theater", Icons.theaters, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TheatersScreen()));
            }),
            _item(context, "City Management", Icons.location_city, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CitiesScreen()));
            }),
            _item(context, "User Account", Icons.person, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const UsersScreen()));
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
