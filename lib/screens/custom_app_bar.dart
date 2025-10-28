import 'dart:ui';
import 'package:flutter/material.dart';

// Giả định các file này đã tồn tại trong project của bạn
import '../services/notification_screen.dart';
import '../screens/setting_screen.dart';

// Màu nền tối cho SettingScreen (Giữ lại các hằng số này để đảm bảo CustomAppBar hoạt động)
const Color _darkBackgroundColor = Color(0xFF1E1E1E);
const Color _textColor = Colors.white;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTransparent;

  const CustomAppBar({super.key, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    // Nếu là transparent, AppBar sẽ chỉ hiển thị nội dung, không có nền
    Widget appBarTitle = Padding(
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
                  // Giữ nguyên logic cũ
                  // Đảm bảo file '../services/notification_screen.dart' đã tồn tại
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
                  // Logic hiển thị SettingScreen chiếm 90% màn hình bên phải
                  // Đảm bảo file '../screens/setting_screen.dart' đã tồn tại
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: '',
                    barrierColor: const Color(0x00000000), // MÀU ĐEN VỚI ALPHA 0 (TRONG SUỐT HOÀN TOÀN)
                    pageBuilder: (context, anim1, anim2) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.8, // Chiếm 90% chiều ngang
                          heightFactor: 1.0, // Chiếm toàn bộ chiều cao
                          child: const SettingScreen(),
                        ),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(1, 0), // Trượt từ phải sang
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
      // Khi isTransparent = true, đặt backgroundColor là trong suốt hoàn toàn
      backgroundColor:
      isTransparent ? Colors.transparent : Colors.red,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 0,

      // Khi isTransparent = true, không còn flexibleSpace nào nữa
      flexibleSpace: null,

      title: appBarTitle,
    );
  }

  @override
  // Kích thước mong muốn của AppBar. Tăng nhẹ kích thước cho thẩm mỹ.
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
