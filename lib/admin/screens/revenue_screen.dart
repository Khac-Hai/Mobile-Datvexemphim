import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  Future<int> _getTotalRevenue() async {
    final snapshot =
    await FirebaseFirestore.instance.collection("tickets").get();

    int total = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data();
      total += (data["total"] ?? 0) as int;
    }

    return total;
  }

  Future<int> _getTotalTickets() async {
    final snapshot =
    await FirebaseFirestore.instance.collection("tickets").get();

    return snapshot.docs.length;
  }

  /// tổng khuyến mãi đã dùng
  Future<int> _getUsedPromotions() async {
    final snapshot =
    await FirebaseFirestore.instance.collection("tickets").get();

    int count = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (data["promotionId"] != null) {
        count++;
      }
    }

    return count;
  }

  Widget _card({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.2), Colors.white],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [

          /// icon
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),

          const SizedBox(width: 20),

          /// text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê doanh thu"),
        backgroundColor: Colors.red.shade700,
      ),

      backgroundColor: const Color(0xfff5f6fa),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: FutureBuilder<List<int>>(
          future: Future.wait([
            _getTotalRevenue(),
            _getTotalTickets(),
            _getUsedPromotions(),
          ]),

          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final revenue = snapshot.data![0];
            final tickets = snapshot.data![1];
            final promotions = snapshot.data![2];

            return Column(
              children: [

                /// doanh thu
                _card(
                  title: "Tổng doanh thu",
                  value: "$revenue VND",
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),

                const SizedBox(height: 20),

                /// vé bán
                _card(
                  title: "Số vé đã bán",
                  value: "$tickets vé",
                  icon: Icons.confirmation_number,
                  color: Colors.orange,
                ),

                const SizedBox(height: 20),

                /// khuyến mãi đã dùng
                _card(
                  title: "Khuyến mãi đã dùng",
                  value: "$promotions lần",
                  icon: Icons.local_offer,
                  color: Colors.purple,
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}