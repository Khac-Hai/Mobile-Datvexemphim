import 'package:flutter/material.dart';
import 'time_slot_screen.dart';

class ChonPhim extends StatefulWidget {
  final String selectedCinema;

  const ChonPhim({super.key, required this.selectedCinema});

  @override
  State<ChonPhim> createState() => _ChonPhimState();
}

class _ChonPhimState extends State<ChonPhim> {
  // Danh sách phim mẫu
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Avengers: Endgame',
      'image':
      'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
      'duration': '3h 2m',
      'genre': 'Action, Sci-Fi',
    },
    {
      'title': 'Cục vàng của ngoại',
      'image':
      'https://www.cgv.vn/media/catalog/product/cache/1/thumbnail/240x388/c88460ec71d04fa96e628a21494d2fd3/4/7/470wx700h-cvcn_1.jpg',
      'duration': '2h 28m',
      'genre': 'Gia đình, Tâm lý',
    },
    {
      'title': 'Cải Mả ',
      'image':
      'https://www.cgv.vn/media/catalog/product/cache/1/thumbnail/240x388/c88460ec71d04fa96e628a21494d2fd3/6/7/675wx1000h_1.jpg',
      'duration': '1h 50m',
      'genre': 'Kinh dị',
    },
    {
      'title': 'Điện thoại đen',
      'image':
      'https://www.cgv.vn/media/catalog/product/cache/1/thumbnail/240x388/c88460ec71d04fa96e628a21494d2fd3/4/7/470x700-tbp2.jpg',
      'duration': '2h 56m',
      'genre': 'Kinh dị',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chọn phim tại ${widget.selectedCinema}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                // Khi nhấn vào phim -> sang chọn giờ chiếu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TimeSlotScreen(
                      cinema: widget.selectedCinema,
                      movie: movie['title'],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        movie['image'],
                        height: 120,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Thể loại: ${movie['genre']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Thời lượng: ${movie['duration']}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 6),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // ✅ Cũng điều hướng giống khi nhấn vào thẻ phim
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TimeSlotScreen(
                                      cinema: widget.selectedCinema,
                                      movie: movie['title'],
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Chọn giờ chiếu',
                                style: TextStyle(color: Colors.white),
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
    );
  }
}
