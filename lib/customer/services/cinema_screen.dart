import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/chonphim.dart';
import 'seat_selection_screen.dart';
import '../services/time_slot_screen.dart';

class CinemaScreen extends StatefulWidget {
  final String? selectedMovie;
  const CinemaScreen({super.key, this.selectedMovie});

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  int selectedIndex = 0;
  String? selectedCinema;
  final Set<String> favoriteCinemas = {};

  void toggleFavorite(String cinema) {
    setState(() {
      if (favoriteCinemas.contains(cinema)) {
        favoriteCinemas.remove(cinema);
      } else if (favoriteCinemas.length < 3) {
        favoriteCinemas.add(cinema);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bạn chỉ có thể chọn tối đa 3 rạp yêu thích.')),
        );
      }
    });
  }

  bool isFavorite(String cinema) => favoriteCinemas.contains(cinema);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // ======== THANH TIÊU ĐỀ ========
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 14,
            ),
            color: Colors.red.shade700,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      "CHỌN RẠP XEM PHIM",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          // ======== DANH SÁCH VÙNG + RẠP ========
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("regions").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Center(child: Text("Chưa có rạp nào.", style: TextStyle(fontSize: 16, color: Colors.black54)));
                }
                return Row(
                  children: [
                    // Cột vùng miền
                    Container(
                      width: 160,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final region = docs[index].id;
                          final isSelected = selectedIndex == index;
                          return ListTile(
                            title: Text(region, style: TextStyle(color: isSelected ? Colors.red : Colors.black87)),
                            onTap: () => setState(() => selectedIndex = index),
                          );
                        },
                      ),
                    ),
                    // Danh sách rạp con
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final data = docs[selectedIndex].data() as Map<String, dynamic>;
                          final cinemas = List<String>.from(data["cinemas"] ?? []);
                          if (cinemas.isEmpty) {
                            return const Center(child: Text("Không có rạp trong vùng này."));
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: cinemas.length,
                            itemBuilder: (context, i) {
                              final cinema = cinemas[i];
                              final favorite = isFavorite(cinema);
                              return Card(
                                child: ListTile(
                                  title: Text(cinema),
                                  trailing: IconButton(
                                    icon: Icon(favorite ? Icons.favorite : Icons.favorite_border,
                                        color: favorite ? Colors.red : Colors.grey),
                                    onPressed: () => toggleFavorite(cinema),
                                  ),
                                  onTap: () => setState(() => selectedCinema = cinema),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // ======== NÚT TIẾP TỤC ========
          if (selectedCinema != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                label: Text("Tiếp tục với rạp: $selectedCinema", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: () {
                  if (widget.selectedMovie != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TimeSlotScreen(cinema: selectedCinema!, movie: widget.selectedMovie!)),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChonPhim(selectedCinema: selectedCinema!)),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
