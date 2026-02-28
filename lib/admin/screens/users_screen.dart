import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_user_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản người dùng"),
        backgroundColor: Colors.red.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;

          if (users.isEmpty) {
            return const Center(
              child: Text(
                "Không có tài khoản nào",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final uid = user.id;
              final data = user.data() as Map<String, dynamic>? ?? {};

              // Lấy email an toàn: ưu tiên 'email', fallback sang 'e-mail'
              final email = data['email'] ?? data['e-mail'] ?? 'Chưa có email';
              final role = data['role'] ?? 'unknown';

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.redAccent),
                  title: Text(
                    email,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Role: $role\nUID: $uid",
                    style: const TextStyle(color: Colors.black87),
                  ),
                  trailing: const Icon(Icons.edit, color: Colors.redAccent),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditUserScreen(uid: uid),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
