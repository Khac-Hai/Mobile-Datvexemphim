import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<HomeScreen> {
  int _currentIndex = 0;
  double _currentMoviePage = 0.0;
  final PageController _movieController = PageController(viewportFraction: 0.85);

  final List<Movie> movies = Movie.sampleMovies;

  @override
  void initState() {
    super.initState();
    _movieController.addListener(() {
      setState(() {
        _currentMoviePage = _movieController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _movieController.dispose();
    super.dispose();
  }

  void _openDetail(String title, String imageUrl, String description, [String? note]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          title: title,
          imageUrl: imageUrl,
          description: description,
          note: note,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int currentMovieIndex = _currentMoviePage.round();
    final String bgImage = movies[currentMovieIndex.clamp(0, movies.length - 1)].poster;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 🌈 NỀN ĐỘNG — thay đổi theo phim (có hiệu ứng đen mờ phía dưới)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Container(
              key: ValueKey(bgImage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(bgImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                      Colors.black,
                    ],
                    stops: [0.4, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Toàn bộ nội dung phía trên
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // ===== AppBar tuỳ chỉnh =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Menu đang được phát triển")),
                          );
                        },
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.account_balance_wallet_outlined,
                                color: Colors.white, size: 30),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Tính năng ví đang được phát triển")),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.person_outline_rounded,
                                color: Colors.white, size: 30),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SettingsScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // === Danh sách phim ===
                SizedBox(
                  height: 560,
                  child: PageView.builder(
                    controller: _movieController,
                    itemCount: movies.length,
                    onPageChanged: (index) => setState(() {}),
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      double scale = (1 - ((_currentMoviePage - index).abs() * 0.15))
                          .clamp(0.85, 1.0);

                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(24)),
                                child: Image.network(
                                  movie.poster,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 360,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            movie.title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "⭐ ${movie.rating}   ⏱ ${movie.duration}   📅 ${movie.date}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade700,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 60, vertical: 12),
                                        ),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Đặt vé cho ${movie.title} thành công!"),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "ĐẶT VÉ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // === Banner và chính sách ===
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _openDetail(
                          "Ra mắt ly mới phiên bản Halloween 2025",
                          "https://media.lottecinemavn.com/Media/WebAdmin/e790bbe8c08046518dc977b638c9d84e.jpg",
                          "Đón mùa Halloween năm nay tại rạp với nhiều phim hay cùng chiếc ly nước thiết kế đặc biệt!\n\nMẫu ly sẽ sớm có mặt tại tất cả các cụm rạp LOTTE Cinema trên toàn quốc.",
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            'https://media.lottecinemavn.com/Media/WebAdmin/e790bbe8c08046518dc977b638c9d84e.jpg',
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _openDetail(
                          "Mừng ngày 20/10 – Ưu đãi cho nàng",
                          "https://media.lottecinemavn.com/Media/WebAdmin/8385293b2be74d4b832484f5a6ec9726.jpg",
                          "Mừng ngày Phụ nữ Việt Nam xem phim chỉ từ 45K, LOTTE CINEMA còn tặng ngay HOA XINH cho các nàng khi: Mua 2 VÉ XEM PHIM kèm COMBO BẮP NƯỚC BẤT KỲ (Áp dụng tại tất cả các cụm rạp, số lượng có hạn).",
                          "1. Vé có thể được đặt online hoặc mua trực tiếp tại quầy.\n2. Riêng combo bắp nước ưu đãi vui lòng mua trực tiếp tại quầy.",
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            'https://media.lottecinemavn.com/Media/WebAdmin/8385293b2be74d4b832484f5a6ec9726.jpg',
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // === Các liên kết cuối ===
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => _openDetail("Điều Khoản Sử Dụng", "",
                                "Đây là các điều khoản quy định về việc sử dụng ứng dụng, quyền lợi và nghĩa vụ của người dùng đối với hệ thống đặt vé."),
                            child: const Text(
                              "Điều Khoản Sử Dụng",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () => _openDetail("Chính Sách Bảo Mật Thông Tin", "",
                                "Chúng tôi cam kết bảo mật thông tin cá nhân của người dùng, không chia sẻ cho bên thứ ba khi chưa được sự đồng ý."),
                            child: const Text(
                              "Chính Sách Bảo Mật Thông Tin",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () => _openDetail("Chính Sách Khách Hàng Thường Xuyên", "",
                                "Khách hàng thân thiết được tích điểm khi mua vé và combo, có thể đổi quà và nhận ưu đãi độc quyền mỗi tháng."),
                            child: const Text(
                              "Chính Sách Khách Hàng Thường Xuyên",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // === Thanh điều hướng ===
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: BottomNavigationBar(
                backgroundColor: Colors.black.withOpacity(0.85),
                selectedItemColor: Colors.red.shade700,
                unselectedItemColor: Colors.white70,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) => setState(() => _currentIndex = index),
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Phim'),
                  BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Quà tặng'),
                  BottomNavigationBarItem(icon: Icon(Icons.local_movies), label: 'Rạp'),
                  BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Khuyến mãi'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============== TRANG CHI TIẾT =================
class DetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String? note;

  const DetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            const SizedBox(height: 20),
            Text(description,
                style: const TextStyle(fontSize: 15, color: Colors.black)),
            if (note != null) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Lưu ý:\n$note",
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
