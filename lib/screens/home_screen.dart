import 'package:flutter/material.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      {"title": "Avengers", "logo": "https://picsum.photos/400/200"},
      {"title": "Batman", "logo": "https://picsum.photos/400/201"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Đặt vé xem phim")),
      body: ListView(
        children: movies
            .map((m) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieDetailScreen(
                title: m["title"]!,
                imageUrl: m["logo"]!,
              ),
            ),
          ),
          child: MovieCard(
            title: m["title"]!,
            imageUrl: m["logo"]!,
          ),
        ))
            .toList(),
      ),
    );
  }
}
