import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Đăng ký tài khoản (không gửi email xác thực)
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Không gửi email xác thực nữa
      return result.user;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  // 🔹 Đăng nhập (không kiểm tra emailVerified)
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Không kiểm tra email xác thực nữa
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");
      return null;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  // 🔹 Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
