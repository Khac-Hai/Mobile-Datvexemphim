import 'package:flutter/material.dart';
import 'seat_selection_screen.dart';

class TimeSlotScreen extends StatelessWidget {
  final String cinema;
  final String movie; // ✅ Thêm dòng này

  const TimeSlotScreen({
    super.key,
    required this.cinema,
    required this.movie, // ✅ Thêm dòng này
  });

  @override
  Widget build(BuildContext context) {
    final timeSlots = [
      "08:00 AM",
      "09:30 AM",
      "10:00 AM",
      "11:15 AM",
      "12:30 PM",
      "01:45 PM",
      "03:00 PM",
      "04:15 PM",
      "05:30 PM",
      "06:45 PM",
      "08:00 PM",
      "09:15 PM",
      "10:30 PM"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn khung giờ - $movie",
        style: const TextStyle(color: Colors.white)), // ✅ Hiển thị tên phim
        backgroundColor: Colors.red.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slot = timeSlots[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              title: Text(
                slot,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeatSelectionScreen(
                      cinema: cinema,
                      movie: movie, // ✅ Truyền tiếp tên phim qua chọn ghế
                      timeSlot: slot,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
