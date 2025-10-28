import 'package:flutter/material.dart';
import 'seat_selection_screen.dart';

class TimeSlotScreen extends StatelessWidget {
  final String cinema;
  const TimeSlotScreen({super.key, required this.cinema});

  @override
  Widget build(BuildContext context) {
    final timeSlots = [
      "10:00 AM",
      "12:30 PM",
      "03:00 PM",
      "05:30 PM",
      "08:00 PM"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn khung giờ - $cinema"),
        backgroundColor: Colors.red.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slot = timeSlots[index];
          return Card(
            child: ListTile(
              title: Text(slot),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SeatSelectionScreen(cinema: cinema, timeSlot: slot),
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
