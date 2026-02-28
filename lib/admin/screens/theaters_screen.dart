import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TheatersScreen extends StatefulWidget {
  const TheatersScreen({super.key});

  @override
  State<TheatersScreen> createState() => _TheatersScreenState();
}

class _TheatersScreenState extends State<TheatersScreen> {
  final _regionController = TextEditingController();
  final _cinemaController = TextEditingController();

  Future<void> _addCinema() async {
    if (_regionController.text.isNotEmpty && _cinemaController.text.isNotEmpty) {
      final regionDoc = FirebaseFirestore.instance.collection("regions").doc(_regionController.text);
      await regionDoc.set({
        "cinemas": FieldValue.arrayUnion([_cinemaController.text])
      }, SetOptions(merge: true));
      _cinemaController.clear();
    }
  }

  Future<void> _deleteCinema(String region, String cinema) async {
    final regionDoc = FirebaseFirestore.instance.collection("regions").doc(region);
    await regionDoc.update({
      "cinemas": FieldValue.arrayRemove([cinema])
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý rạp"), backgroundColor: Colors.red.shade700),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Form thêm rạp
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(controller: _regionController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Tên vùng")),
                    const SizedBox(height: 12),
                    TextField(controller: _cinemaController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Tên rạp")),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _addCinema,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text("Thêm rạp"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Danh sách rạp theo vùng
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("regions").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(child: Text("Chưa có rạp nào.", style: TextStyle(color: Colors.black54)));
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final region = docs[index].id;
                      final data = docs[index].data() as Map<String, dynamic>;
                      final cinemas = List<String>.from(data["cinemas"] ?? []);
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: ExpansionTile(
                          title: Text(region, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          children: cinemas.map((cinema) {
                            return ListTile(
                              title: Text(cinema, style: const TextStyle(color: Colors.black87)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () => _deleteCinema(region, cinema),
                              ),
                            );
                          }).toList(),
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
