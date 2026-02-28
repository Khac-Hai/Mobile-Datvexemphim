import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserScreen extends StatefulWidget {
  final String uid;
  const EditUserScreen({required this.uid, super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  String _role = 'customer';
  bool _loading = false;
  bool _notFound = false;

  Future<void> _loadUser() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
    if (!doc.exists) {
      setState(() => _notFound = true);
      return;
    }

    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      setState(() => _notFound = true);
      return;
    }

    _emailController.text = data['email'] ?? data['e-mail'] ?? '';
    _nameController.text = data['name'] ?? '';
    _role = data['role'] ?? 'customer';
    setState(() {});
  }

  Future<void> _updateUser() async {
    setState(() => _loading = true);
    await FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
      'email': _emailController.text.trim(),
      'name': _nameController.text.trim(),
      'role': _role,
    });

    // Xóa trường sai nếu có
    await FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
      'e-mail': FieldValue.delete(),
    });

    setState(() => _loading = false);
    Navigator.pop(context);
  }

  Future<void> _deleteUser() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.uid).delete();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chỉnh sửa tài khoản"), backgroundColor: Colors.red.shade700),
      backgroundColor: Colors.grey[100],
      body: _notFound
          ? const Center(
        child: Text(
          "Không tìm thấy tài khoản",
          style: TextStyle(color: Colors.redAccent, fontSize: 18),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(controller: _emailController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Email")),
                const SizedBox(height: 16),
                TextField(controller: _nameController, style: const TextStyle(color: Colors.black), decoration: _inputDecoration("Tên người dùng")),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _role,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration("Vai trò"),
                  items: const [
                    DropdownMenuItem(value: 'customer', child: Text("Khách hàng")),
                    DropdownMenuItem(value: 'admin', child: Text("Quản lý")),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _role = value);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _updateUser,
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text("Cập nhật"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _deleteUser,
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  label: const Text("Xóa tài khoản", style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
