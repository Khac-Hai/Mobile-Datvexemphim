import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _posterController = TextEditingController();
  final _ratingController = TextEditingController();
  final _durationController = TextEditingController();
  final _dateController = TextEditingController();

  Future<void> _addMovie() async {
    await FirebaseFirestore.instance.collection("movies").add({
      "title": _titleController.text,
      "poster": _posterController.text,
      "rating": _ratingController.text,
      "duration": _durationController.text,
      "date": _dateController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("🎬 Đã thêm phim mới")),
    );
    _formKey.currentState!.reset();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  TextStyle _inputTextStyle() {
    return const TextStyle(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý phim"),
        backgroundColor: Colors.red.shade700,
        elevation: 4,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Form thêm phim
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(controller: _titleController, style: _inputTextStyle(), decoration: _inputDecoration("Tên phim")),
                      const SizedBox(height: 12),
                      TextFormField(controller: _posterController, style: _inputTextStyle(), decoration: _inputDecoration("Poster URL")),
                      const SizedBox(height: 12),
                      TextFormField(controller: _ratingController, style: _inputTextStyle(), decoration: _inputDecoration("Rating")),
                      const SizedBox(height: 12),
                      TextFormField(controller: _durationController, style: _inputTextStyle(), decoration: _inputDecoration("Thời lượng")),
                      const SizedBox(height: 12),
                      TextFormField(controller: _dateController, style: _inputTextStyle(), decoration: _inputDecoration("Ngày chiếu")),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                        ),
                        onPressed: _addMovie,
                        icon: const Icon(Icons.add),
                        label: const Text("Thêm phim", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Danh sách phim
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("movies").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(child: Text("Chưa có phim nào.", style: TextStyle(color: Colors.black54)));
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final movie = doc.data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(movie["poster"], width: 60, fit: BoxFit.cover),
                          ),
                          title: Text(movie["title"], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          subtitle: Text("⏱ ${movie["duration"]}   📅 ${movie["date"]}", style: const TextStyle(color: Colors.black87)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection("movies").doc(doc.id).delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("❌ Đã xóa phim: ${movie["title"]}")),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
