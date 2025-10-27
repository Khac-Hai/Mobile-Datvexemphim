import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/notification_screen.dart';
import '../screens/setting_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTransparent;
  const CustomAppBar({super.key, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
      isTransparent ? Colors.black.withOpacity(0.2) : Colors.red,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      flexibleSpace: isTransparent
          ? ClipRect(
          //filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // ✅ Hiệu ứng mờ kính
          child: Container(
            color: Colors.black.withOpacity(0.15),
          ),

      )
          : null,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Menu đang được phát triển"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined,
                      color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline_rounded,
                      color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
