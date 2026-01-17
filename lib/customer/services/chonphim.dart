import 'package:flutter/material.dart';
import 'time_slot_screen.dart';
import 'package:datvexemphim/customer/models/movie.dart'; // 👈 nhớ import file Movie vào

class ChonPhim extends StatefulWidget {
  final String selectedCinema;

  const ChonPhim({super.key, required this.selectedCinema});

  @override
  State<ChonPhim> createState() => _ChonPhimState();
}

class _ChonPhimState extends State<ChonPhim> {
  final List<Movie> movies = Movie.sampleMovies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chọn phim tại ${widget.selectedCinema}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
                      movie: movie.title,
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
                        movie.poster,
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
                              movie.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Thời lượng: ${movie.duration}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Khởi chiếu: ${movie.date}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Đánh giá: ⭐ ${movie.rating}',
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TimeSlotScreen(
                                      cinema: widget.selectedCinema,
                                      movie: movie.title,
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
