import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final _codeController = TextEditingController();
  final _descController = TextEditingController();

  Future<void> _addVoucher() async {
    if (_codeController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("vouchers").add({
        "code": _codeController.text,
        "description": _descController.text,
        "createdAt": DateTime.now(),
      });
      _codeController.clear();
      _descController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🎁 Voucher đã được thêm!")),
      );
    }
  }

  Future<void> _deleteVoucher(String id, String code) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: Text("Bạn có chắc muốn xóa voucher: $code ?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Hủy")),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Xóa")),
        ],
      ),
    );
    if (confirm == true) {
      await FirebaseFirestore.instance.collection("vouchers").doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Voucher $code đã bị xóa")),
      );
    }
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
      appBar: AppBar(
        title: const Text("Quản lý voucher"),
        backgroundColor: Colors.red.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Form thêm voucher
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
                    TextField(controller: _codeController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Mã voucher")),
                    const SizedBox(height: 12),
                    TextField(controller: _descController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Mô tả")),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _addVoucher,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text("Thêm voucher"),
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

          // Danh sách voucher
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("vouchers").orderBy("createdAt", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Center(child: Text("Chưa có voucher nào.", style: TextStyle(color: Colors.black54)));
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final voucher = doc.data() as Map<String, dynamic>;
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(voucher["code"] ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        subtitle: Text(voucher["description"] ?? "", style: const TextStyle(color: Colors.black87)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteVoucher(doc.id, voucher["code"] ?? ""),
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
