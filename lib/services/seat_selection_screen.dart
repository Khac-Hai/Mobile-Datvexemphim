import 'package:flutter/material.dart';
import 'payment_screen.dart'; // ✅ thêm dòng import này

class SeatSelectionScreen extends StatefulWidget {
  final String cinema;
  final String movie;
  final String timeSlot;

  const SeatSelectionScreen({
    super.key,
    required this.cinema,
    required this.movie,
    required this.timeSlot,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final Set<String> selectedSeats = {};
  final Set<String> bookedSeats = {
    'A1', 'A2', 'B4', 'C5', 'D8', 'E3'
  }; // ✅ giả lập ghế đã đặt

  static const int seatPrice = 50000; // 💰 Giá 1 ghế: 50.000 VND

  @override
  Widget build(BuildContext context) {
    const rows = 5;
    const cols = 8;

    final int totalPrice = selectedSeats.length * seatPrice; // ✅ tổng tiền

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Đặt ghế - ${widget.movie}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.red.shade700,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// Thông tin phim
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "🎬 ${widget.movie}\n Rạp: ${widget.cinema} •  Suất: ${widget.timeSlot}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),

          /// Màn hình chiếu
          Container(
            width: 240,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade300, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(80),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              "MÀN HÌNH CHIẾU",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// Huyền thoại ghế (Legend)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendBox(Colors.grey.shade300, "Trống"),
                _buildLegendBox(Colors.red.shade700, "Đang chọn"),
                _buildLegendBox(Colors.black87, "Đã đặt"),
              ],
            ),
          ),

          const SizedBox(height: 150),

          /// Danh sách ghế
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

                final bool isBooked = bookedSeats.contains(seatId);
                final bool isSelected = selectedSeats.contains(seatId);

                Color seatColor;
                if (isBooked) {
                  seatColor = Colors.black87;
                } else if (isSelected) {
                  seatColor = Colors.red.shade700;
                } else {
                  seatColor = Colors.grey.shade300;
                }

                return GestureDetector(
                  onTap: isBooked
                      ? null
                      : () {
                    setState(() {
                      if (isSelected) {
                        selectedSeats.remove(seatId);
                      } else {
                        selectedSeats.add(seatId);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: seatColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ]
                          : [],
                    ),
                    child: Text(
                      seatId,
                      style: TextStyle(
                        color: isBooked
                            ? Colors.white70
                            : isSelected
                            ? Colors.white
                            : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// 💵 Hiển thị tổng giá vé
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              selectedSeats.isEmpty
                  ? "Chưa chọn ghế"
                  : "Tổng tiền: ${totalPrice.toString()} VND",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selectedSeats.isEmpty ? Colors.black54 : Colors.red,
              ),
            ),
          ),

          /// Nút Tiếp tục
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: GestureDetector(
              onTap: selectedSeats.isEmpty
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      cinema: widget.cinema,
                      movie: widget.movie,
                      timeSlot: widget.timeSlot,
                      seats: selectedSeats.toList(),
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: selectedSeats.isEmpty
                      ? LinearGradient(colors: [
                    Colors.grey.shade400,
                    Colors.grey.shade300
                  ])
                      : const LinearGradient(
                    colors: [Colors.redAccent, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: selectedSeats.isEmpty
                      ? []
                      : [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  selectedSeats.isEmpty
                      ? "Chọn ghế để tiếp tục"
                      : "Tiếp tục (${selectedSeats.length}) ghế",
                  style: TextStyle(
                    color: selectedSeats.isEmpty
                        ? Colors.black54
                        : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hàm tạo ô nhỏ cho phần chú thích màu ghế
  Widget _buildLegendBox(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
