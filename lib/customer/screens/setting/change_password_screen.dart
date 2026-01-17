import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePassword() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      // Lấy email hiện tại của người dùng
      final email = user.email!;

      // Xác thực lại người dùng bằng email + mật khẩu cũ
      final cred = EmailAuthProvider.credential(
        email: email,
        password: _oldPass.text,
      );
      await user.reauthenticateWithCredential(cred);

      // Sau khi xác thực thành công, cập nhật mật khẩu mới
      await user.updatePassword(_newPass.text);

      // Hiển thị thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đã đổi mật khẩu thành công!")),
      );

      _oldPass.clear();
      _newPass.clear();
    } on FirebaseAuthException catch (e) {
      String message = "Đã xảy ra lỗi!";
      if (e.code == 'wrong-password') {
        message = "Mật khẩu hiện tại không đúng!";
      } else if (e.code == 'weak-password') {
        message = "Mật khẩu mới quá yếu!";
      } else if (e.code == 'requires-recent-login') {
        message = "Vui lòng đăng nhập lại để đổi mật khẩu.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _oldPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Mật khẩu hiện tại"),
            ),
            TextField(
              controller: _newPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Mật khẩu mới"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Xác nhận"),
            ),
          ],
        ),
      ),
    );
  }
}
