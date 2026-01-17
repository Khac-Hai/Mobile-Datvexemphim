import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/notification_screen.dart';
import 'setting_screen.dart';
import 'menu.dart'; //  thêm dòng này

// Màu nền tối cho SettingScreen
const Color _darkBackgroundColor = Color(0xFF1E1E1E);
const Color _textColor = Colors.white;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTransparent;

  const CustomAppBar({super.key, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút menu bên trái
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () {
              //  Hiển thị Menu trượt từ trái sang phải
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                barrierColor: const Color(0x00000000), // trong suốt hoàn toàn
                pageBuilder: (context, anim1, anim2) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: 0.8, // chiếm 80% chiều ngang
                      heightFactor: 1.0,
                      child: const CustomMenu(),
                    ),
                  );
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(-1, 0), // trượt từ TRÁI sang PHẢI
                    end: Offset.zero,
                  ).animate(anim1);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              );
            },
          ),

          // Nhóm icon bên phải
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
                  //  Hiển thị Setting trượt từ phải sang trái
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: '',
                    barrierColor: const Color(0x00000000),
                    pageBuilder: (context, anim1, anim2) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 1.0,
                          child: const SettingScreen(),
                        ),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(1, 0), // trượt từ PHẢI sang TRÁI
                        end: Offset.zero,
                      ).animate(anim1);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );

    return AppBar(
      backgroundColor:
      isTransparent ? Colors.transparent : Colors.red,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      flexibleSpace: null,
      title: appBarTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
