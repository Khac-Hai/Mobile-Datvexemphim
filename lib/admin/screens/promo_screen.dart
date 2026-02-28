import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromoAdminScreen extends StatefulWidget {
  const PromoAdminScreen({super.key});

  @override
  State<PromoAdminScreen> createState() => _PromoAdminScreenState();
}

class _PromoAdminScreenState extends State<PromoAdminScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  Future<void> _addPromo() async {
    if (_titleController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("promotions").add({
        "title": _titleController.text,
        "desc": _descController.text,
        "createdAt": DateTime.now(),
      });
      _titleController.clear();
      _descController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🔥 Khuyến mãi đã được thêm!")),
      );
    }
  }

  Future<void> _deletePromo(String id, String title) async {
    await FirebaseFirestore.instance.collection("promotions").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ Khuyến mãi $title đã bị xóa")),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _statCard(String title, int value) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              "$value",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý khuyến mãi"), backgroundColor: Colors.red.shade700),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Form thêm khuyến mãi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(controller: _titleController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Tiêu đề")),
                    const SizedBox(height: 12),
                    TextField(controller: _descController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Mô tả")),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _addPromo,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text("Thêm khuyến mãi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Danh sách khuyến mãi
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("promotions").orderBy("createdAt", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Center(child: Text("Chưa có khuyến mãi nào.", style: TextStyle(color: Colors.black54)));
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final promo = doc.data() as Map<String, dynamic>;
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: ListTile(
                        title: Text(promo["title"] ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        subtitle: Text(promo["desc"] ?? "", style: const TextStyle(color: Colors.black87)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deletePromo(doc.id, promo["title"] ?? ""),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
