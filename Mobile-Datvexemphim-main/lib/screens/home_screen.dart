import 'package:flutter/material.dart';

void main() {
  runApp(MovieBookingApp());
}

class MovieBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Đặt vé xem phim',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<HomeScreen> {
  int _currentIndex = 0;
  double _currentMoviePage = 0.0;
  final PageController _movieController = PageController(viewportFraction: 0.85);

  final List<Map<String, String>> movies = [
    {
      'title': 'CỤC VÀNG CỦA NGOẠI',
      'poster':
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/4/7/470wx700h-cvcn_1.jpg',
      'rating': '7.5',
      'duration': '119 Phút',
      'date': '17/10/2025'
    },
    {
      'title': 'CHỊ NGÃ EM NÂNG',
      'poster':
      'https://api-website.cinestar.com.vn/media/wysiwyg/Posters/10-2025/CNEN_MAIN2_1500x1200.jpg',
      'rating': '7.2',
      'duration': '122 Phút',
      'date': '03/10/2025'
    },
    {
      'title': 'NĂM CỦA ANH, NGÀY CỦA EM',
      'poster':
      'https://api-website.cinestar.com.vn/media/wysiwyg/Posters/10-2025/nam-cua-anh-ngay-cua-em-poster.jpg',
      'rating': '7.8',
      'duration': '126 Phút',
      'date': '25/10/2025'
    },
    {
      'title': 'TỬ CHIẾN TRÊN KHÔNG',
      'poster':
      'https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/m/a/main_tctk_social.jpg',
      'rating': '9.6',
      'duration': '118 Phút',
      'date': '19/09/2025'
    },
  ];

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

  // 👉 Mở trang chi tiết (dùng cho cả khuyến mãi và chính sách)
  void _openDetail(String title, String imageUrl, String description,
      [String? note]) {
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
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Phim đang chiếu",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child:
            Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.person_outline, color: Colors.white),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            // === Danh sách phim ===
            SizedBox(
              height: 560,
              child: PageView.builder(
                controller: _movieController,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  double scale =
                  (1 - ((_currentMoviePage - index).abs() * 0.15))
                      .clamp(0.85, 1.0);

                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24)),
                            child: Image.network(
                              movie['poster']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 360,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                              const EdgeInsets.fromLTRB(12, 12, 12, 20),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        movie['title']!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "⭐ ${movie['rating']}   ⏱ ${movie['duration']}   📅 ${movie['date']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.red.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 12),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Đặt vé cho ${movie['title']} thành công!"),
                                          duration:
                                          const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "ĐẶT VÉ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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

            // === Banner khuyến mãi ===
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

                  // === 3 dòng chữ cuối ===
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => _openDetail(
                          "Điều Khoản Sử Dụng",
                          "",
                          "Đây là các điều khoản quy định về việc sử dụng ứng dụng, quyền lợi và nghĩa vụ của người dùng đối với hệ thống đặt vé.",
                        ),
                        child: const Text(
                          "Điều Khoản Sử Dụng",
                          style:
                          TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _openDetail(
                          "Chính Sách Bảo Mật Thông Tin",
                          "",
                          "Chúng tôi cam kết bảo mật thông tin cá nhân của người dùng, không chia sẻ cho bên thứ ba khi chưa được sự đồng ý.",
                        ),
                        child: const Text(
                          "Chính Sách Bảo Mật Thông Tin",
                          style:
                          TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _openDetail(
                          "Chính Sách Khách Hàng Thường Xuyên",
                          "",
                          "Khách hàng thân thiết được tích điểm khi mua vé và combo, có thể đổi quà và nhận ưu đãi độc quyền mỗi tháng.",
                        ),
                        child: const Text(
                          "Chính Sách Khách Hàng Thường Xuyên",
                          style:
                          TextStyle(color: Colors.black, fontSize: 14),
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

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          backgroundColor: Colors.red.shade700,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Phim'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Quà tặng'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_movies), label: 'Rạp'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_offer), label: 'Khuyến mãi'),
          ],
        ),
      ),
    );
  }
}

// =================== TRANG CHI TIẾT ===================
class DetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String? note;

  const DetailPage({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title,
            style: const TextStyle(color: Colors.white)),
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
            Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            if (note != null) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Lưu ý:\n$note",
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1.4),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}