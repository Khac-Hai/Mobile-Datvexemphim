import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class WatchedMoviesScreen extends StatelessWidget {
  const WatchedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Phim đã xem',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('userId', isEqualTo: user?.uid) // 👈 lọc vé theo người dùng
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.redAccent));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Bạn chưa xem phim nào.',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          }

          final tickets = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final data = tickets[index].data() as Map<String, dynamic>;

              final movie = data['movie'] ?? 'Không rõ tên phim';
              final cinema = data['cinema'] ?? 'Không rõ rạp';
              final seat = (data['seats'] as List?)?.join(', ') ?? 'Không rõ ghế';
              final total = data['total'] ?? 0;
              final timeSlot = data['timeSlot'] ?? '';
              final payment = data['paymentMethod'] ?? '';
              final rawDate = data['date']?.toString();

              String formattedDate = '';
              try {
                final date = DateTime.parse(rawDate ?? '');
                formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
              } catch (_) {
                formattedDate = rawDate ?? '';
              }

              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.movie, color: Colors.redAccent, size: 40),
                  title: Text(
                    movie,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Rạp: $cinema\nGhế: $seat\nGiờ: $timeSlot - $formattedDate\nThanh toán: $payment\nTổng: ${total.toString()} VND',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
