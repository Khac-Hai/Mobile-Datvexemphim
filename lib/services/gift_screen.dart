// quà tặng
// lib/services/gift_screen.dart
import 'package:flutter/material.dart';

class GiftScreen extends StatelessWidget {
  const GiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gifts = [
      {
        "title": "🎁 Nhận voucher 100.000đ khi đăng ký thành viên mới",
        "desc": "Đăng ký tài khoản và nhận ngay mã giảm giá cho vé đầu tiên.",
      },
      {
        "title": "🍿 Tặng combo bắp nước cho sinh nhật khách hàng",
        "desc": "Áp dụng trong tuần sinh nhật, chỉ cần mang CMND hoặc CCCD.",
      },
      {
        "title": "🎬 Tặng vé miễn phí cho khách hàng thân thiết",
        "desc": "Thành viên tích đủ 10 vé sẽ được tặng 1 vé xem phim bất kỳ.",
      },
      {
        "title": "💳 Giảm 20% khi thanh toán bằng thẻ ngân hàng đối tác",
        "desc": "Áp dụng cho các thẻ Visa/MasterCard của ngân hàng liên kết.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white, // ✅ nền trắng
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 14,
              bottom: 14,
            ),
            color: Colors.red.shade700,
            child: const Center(
              child: Text(
                "ƯU ĐÂI VÀ QUÀ TẶNG",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: gifts.length,
              itemBuilder: (context, index) {
                final gift = gifts[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      gift["title"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        gift["desc"]!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    trailing: const Icon(Icons.card_giftcard, color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ); // ✅ chú ý dấu ; cuối Scaffold
  }
}
