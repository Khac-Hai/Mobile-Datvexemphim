import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:datvexemphim/models/ticket_model.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  List<Ticket> tickets = [];
  List<String> ticketIds = []; // Lưu id vé trong Firestore
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  /// Lấy vé từ Firestore (ưu tiên) hoặc local SharedPreferences
  Future<void> _loadTickets() async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      if (user != null) {
        //  Lấy dữ liệu từ Firestore collection "tickets"
        final snapshot = await FirebaseFirestore.instance
            .collection('tickets')
            .orderBy('date', descending: true)
            .get();

        setState(() {
          tickets = snapshot.docs.map((doc) {
            final data = doc.data();
            return Ticket.fromJson(data);
          }).toList();

          // lưu id vé để xoá sau này
          ticketIds = snapshot.docs.map((doc) => doc.id).toList();
          isLoading = false;
        });
      } else {
        //  Nếu chưa đăng nhập, lấy từ local
        final prefs = await SharedPreferences.getInstance();
        List<String> data = prefs.getStringList('tickets') ?? [];
        setState(() {
          tickets = data.map((e) => Ticket.fromJson(jsonDecode(e))).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(" Lỗi khi tải vé: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _deleteTicket(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận xoá vé"),
        content: const Text("Bạn có chắc muốn xoá vé này không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Huỷ"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Xoá"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && ticketIds.isNotEmpty && index < ticketIds.length) {
        final ticketId = ticketIds[index];

        //  Xoá trong Firestore
        await FirebaseFirestore.instance
            .collection('tickets')
            .doc(ticketId)
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("🗑️ Đã xoá vé khỏi Firestore!")),
        );

        //  Xoá trong danh sách hiện tại
        setState(() {
          tickets.removeAt(index);
          ticketIds.removeAt(index);
        });
      } else {
        //  Xoá trong SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        List<String> data = prefs.getStringList('tickets') ?? [];
        if (index < data.length) {
          data.removeAt(index);
          await prefs.setStringList('tickets', data);
        }

        setState(() {
          tickets.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("️ Đã xoá vé khỏi thiết bị!")),
        );
      }
    } catch (e) {
      debugPrint(" Lỗi khi xoá vé: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi xoá vé: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vé của tôi"),
        backgroundColor: Colors.redAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tickets.isEmpty
          ? const Center(child: Text("Bạn chưa đặt vé nào 🎟"))
          : ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final t = tickets[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                t.movie,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Tại rạp: ${t.cinema}\n"
                    "Giờ chiếu: ${t.timeSlot}\n"
                    "Ghế: ${t.seats.join(', ')}\n"
                    "Giá vé: ${t.total} VND\n"
                    "Ngày đặt: ${t.date.toLocal().toString().split('.')[0]}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _deleteTicket(index), //  Gọi hàm xoá
              ),
            ),
          );
        },
      ),
    );
  }
}
