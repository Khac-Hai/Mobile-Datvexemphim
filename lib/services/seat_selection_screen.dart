import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String cinema;
  final String timeSlot;

  const SeatSelectionScreen({
    super.key,
    required this.cinema,
    required this.timeSlot,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final Set<String> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    const rows = 5;
    const cols = 8;

    return Scaffold(
      appBar: AppBar(
        title: Text("Đặt ghế - ${widget.cinema} (${widget.timeSlot})"),
        backgroundColor: Colors.red.shade700,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                final row = index ~/ cols;
                final col = index % cols;
                final seatId = '${String.fromCharCode(65 + row)}${col + 1}';
                final selected = selectedSeats.contains(seatId);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        selectedSeats.remove(seatId);
                      } else {
                        selectedSeats.add(seatId);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.red.shade700
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      seatId,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                "Xác nhận ${selectedSeats.length} ghế",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: selectedSeats.isEmpty
                  ? null
                  : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Bạn đã chọn ghế: ${selectedSeats.join(', ')}"),
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
