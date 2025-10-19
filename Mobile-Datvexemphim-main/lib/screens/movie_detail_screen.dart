import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieDetailScreen({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Image.network(imageUrl, height: 300, fit: BoxFit.cover),
          const SizedBox(height: 20),
          Text("Nội dung chi tiết phim sẽ ở đây",
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
