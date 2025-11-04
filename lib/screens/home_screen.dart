import 'package:flutter/material.dart';
import '../services/movie_screen.dart';
import '../services/gift_screen.dart';
import '../services/cinema_screen.dart';
import '../services/promo_screen.dart';
import '../screens/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MovieScreen(),
    GiftScreen(),
    CinemaScreen(),
    PromoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMovieTab = _currentIndex == 0;

    return Scaffold(
      extendBodyBehindAppBar: isMovieTab, //  cho phép phim tràn nền AppBar
      appBar: isMovieTab
          ? const CustomAppBar(isTransparent: true) //  AppBar trong suốt cho tab phim
          : null, //  3 tab còn lại không có AppBar
      backgroundColor: isMovieTab ? Colors.transparent : Colors.black,
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          backgroundColor: Colors.black.withOpacity(0.9),
          selectedItemColor: Colors.red.shade700,
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Phim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Quà tặng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_movies),
              label: 'Rạp',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Khuyến mãi',
            ),
          ],
        ),
      ),
    );
  }
}
