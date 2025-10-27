import 'package:flutter/material.dart';

class CinemaScreen extends StatefulWidget {
  const CinemaScreen({super.key});

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  int selectedIndex = 0;
  String? selectedCinema;
  final Set<String> favoriteCinemas = {};

  final List<Map<String, dynamic>> regions = [
    {'name': 'Rạp của tôi (0/3)', 'cinemas': []},
    {
      'name': 'TPHCM (9)',
      'cinemas': [
        'Cantavil',
        'Cộng Hòa',
        'Gò Vấp',
        'Gold View',
        'Moonlight',
        'Nam Sài Gòn',
        'Nowzone',
        'Phú Thọ',
        'Thủ Đức',
      ]
    },
    {
      'name': 'Hà Nội (4)',
      'cinemas': ['Hà Đông', 'Kosmo', 'Thăng Long', 'West Lake']
    },
    {
      'name': 'Bắc Miền Trung (4)',
      'cinemas': ['Đồng Hới', 'Huế', 'Thanh Hóa', 'Vinh']
    },
    {
      'name': 'Nam Miền Trung (7)',
      'cinemas': [
        'Bảo Lộc',
        'Đà Nẵng',
        'Hội An',
        'Nha Trang Thái Nguyên',
        'Nha Trang Trần Phú',
        'Phan Rang',
        'Phan Thiết'
      ]
    },
    {
      'name': 'Đông Nam Bộ (6)',
      'cinemas': ['Biên Hòa', 'Bình Dương', 'Dĩ An', 'Đồng Nai', 'Vũng Tàu', 'Tây Ninh']
    },
    {
      'name': 'Tây Nam Bộ (4)',
      'cinemas': ['Cà Mau', 'Cần Thơ Cái Răng', 'Cần Thơ Ninh Kiều', 'Long Xuyên']
    },
  ];

  void toggleFavorite(String cinema) {
    setState(() {
      if (favoriteCinemas.contains(cinema)) {
        favoriteCinemas.remove(cinema);
      } else if (favoriteCinemas.length < 3) {
        favoriteCinemas.add(cinema);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bạn chỉ có thể chọn tối đa 3 rạp yêu thích.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      regions[0]['cinemas'] = favoriteCinemas.toList();
      regions[0]['name'] = 'Rạp của tôi (${favoriteCinemas.length}/3)';
    });
  }

  bool isFavorite(String cinema) => favoriteCinemas.contains(cinema);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // ======= HEADER FULL VIỀN (hiển thị cả vùng giờ) =======
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 14,
              bottom: 14,
            ),
            color: Colors.red.shade700,
            child: const Center(
              child: Text(
                "CHỌN RẠP XEM PHIM",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // ======= NỘI DUNG CHÍNH =======
          Expanded(
            child: Row(
              children: [
                // ======= DANH SÁCH KHU VỰC =======
                Container(
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300, width: 0.8),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: regions.length,
                    itemBuilder: (context, index) {
                      final region = regions[index];
                      final isSelected = selectedIndex == index;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: isSelected ? Colors.red.shade50 : Colors.transparent,
                        child: ListTile(
                          dense: true,
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          title: Text(
                            region['name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.red : Colors.black87,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.arrow_right, color: Colors.red)
                              : null,
                          onTap: () => setState(() => selectedIndex = index),
                        ),
                      );
                    },
                  ),
                ),

                // ======= DANH SÁCH RẠP =======
                Expanded(
                  child: Container(
                    color: Colors.grey.shade50,
                    child: (regions[selectedIndex]['cinemas'] as List).isEmpty
                        ? const Center(
                      child: Text(
                        "Bạn chưa thêm rạp yêu thích.",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount:
                      (regions[selectedIndex]['cinemas'] as List).length,
                      itemBuilder: (context, i) {
                        final cinema =
                        (regions[selectedIndex]['cinemas'] as List)[i];
                        final favorite = isFavorite(cinema);

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text(
                              cinema,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                favorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => toggleFavorite(cinema),
                            ),
                            onTap: () =>
                                setState(() => selectedCinema = cinema),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= NÚT TIẾP TỤC =======
          if (selectedCinema != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.white),
                label: Text(
                  "Tiếp tục với rạp: $selectedCinema",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red.shade700,
                      content: Text('🎟️ Đang chọn rạp: $selectedCinema'),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
