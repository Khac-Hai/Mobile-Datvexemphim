import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datvexemphim/customer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:datvexemphim/customer/models/ticket_model.dart';
import 'package:datvexemphim/customer/screens/vecuatoi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentScreen extends StatefulWidget {
  final String cinema;
  final String movie;
  final String timeSlot;
  final List<String> seats;

  const PaymentScreen({
    super.key,
    required this.cinema,
    required this.movie,
    required this.timeSlot,
    required this.seats,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "ck"; // ck = chuyển khoản, tm = tiền mặt

  /// ✅ Lưu ghế đã đặt vào local
  Future<void> _markSeatsAsBooked() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${widget.movie}_${widget.cinema}_${widget.timeSlot}';
    final saved = prefs.getStringList(key) ?? [];
    saved.addAll(widget.seats);
    await prefs.setStringList(key, saved.toSet().toList());
  }

  /// ✅ Lưu vé lên Firebase Firestore
  Future<void> _saveTicketToFirebase(Ticket ticket) async {
    try {
      await FirebaseFirestore.instance.collection('tickets').add({
        'movie': ticket.movie,
        'cinema': ticket.cinema,
        'timeSlot': ticket.timeSlot,
        'seats': ticket.seats,
        'total': ticket.total,
        'date': ticket.date.toIso8601String(),
        'paymentMethod': selectedMethod == 'ck'
            ? 'Chuyển khoản ngân hàng'
            : 'Tiền mặt',
      });
      debugPrint('✅ Vé đã được lưu lên Firebase!');
    } catch (e) {
      debugPrint('❌ Lỗi lưu vé: $e');
    }
  }

  /// ✅ Hiển thị hộp thoại thanh toán thành công
  void _showSuccessDialog(BuildContext context, int total) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Thanh toán thành công!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Bạn đã đặt ${widget.seats.length} ghế cho phim:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
              const SizedBox(height: 6),
              Text(
                widget.movie,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Quay lại trang chủ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int seatPrice = 50000;
    final int total = seatPrice * widget.seats.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Xác nhận thanh toán",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thông tin phim
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🎬 ${widget.movie.toUpperCase()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("📍 Rạp: ${widget.cinema}"),
                  Text("🕒 Suất: ${widget.timeSlot}"),
                  Text("💺 Ghế: ${widget.seats.join(', ')}"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// Chọn hình thức thanh toán
            const Text(
              "Chọn hình thức thanh toán:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            _buildPaymentOption(
              icon: Icons.account_balance,
              title: "Chuyển khoản ngân hàng",
              method: "ck",
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              icon: Icons.payments_rounded,
              title: "Tiền mặt tại rạp",
              method: "tm",
            ),

            const Spacer(),

            /// Tổng tiền
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tổng thanh toán:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$total VND",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Nút xác nhận thanh toán
            GestureDetector(
              onTap: () async {
                final ticket = Ticket(
                  movie: widget.movie,
                  cinema: widget.cinema,
                  timeSlot: widget.timeSlot,
                  seats: widget.seats,
                  total: total,
                  date: DateTime.now(),
                );

                await _saveTicketToFirebase(ticket);
                await _markSeatsAsBooked();
                _showSuccessDialog(context, total);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.redAccent, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Xác nhận thanh toán",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String method,
  }) {
    final bool isSelected = selectedMethod == method;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = method),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red.shade400 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.red.shade700 : Colors.grey.shade600,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                  isSelected ? Colors.red.shade700 : Colors.grey.shade800,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected ? Colors.red.shade700 : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
