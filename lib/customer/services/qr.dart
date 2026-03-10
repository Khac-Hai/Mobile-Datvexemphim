import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:datvexemphim/customer/screens/home_screen.dart';

class QRPaymentScreen extends StatefulWidget {

  final int total;

  const QRPaymentScreen({super.key, required this.total});

  @override
  State<QRPaymentScreen> createState() => _QRPaymentScreenState();
}

class _QRPaymentScreenState extends State<QRPaymentScreen> {

  bool isPaid = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán QR"),
        backgroundColor: Colors.red,
      ),

      body: Center(
        child: isPaid

        /// ======================
        /// MÀN THANH TOÁN THÀNH CÔNG
        /// ======================
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 120,
            ),

            const SizedBox(height: 20),

            const Text(
              "Thanh toán thành công",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 10),

            const Text("Giao dịch đã hoàn tất"),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                      (route) => false,
                );

              },
              child: const Text("Trang chủ"),
            )
          ],
        )

        /// ======================
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Quét QR để thanh toán",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            QrImageView(
              data: "ThanhToan:${widget.total}",
              size: 220,
            ),

            const SizedBox(height: 20),

            Text(
              "Số tiền: ${widget.total} VND",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                setState(() {
                  isPaid = true;
                });
              },
              child: const Text("Đã thanh toán"),
            )
          ],
        ),
      ),
    );
  }
}