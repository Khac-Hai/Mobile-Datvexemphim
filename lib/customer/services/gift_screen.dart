// lib/services/gift_screen.dart
import 'package:flutter/material.dart';

class GiftScreen extends StatelessWidget {
  const GiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gifts = [
      {
        "title": "Nhận voucher 100.000đ khi đăng ký thành viên mới",
        "desc": "Đăng ký tài khoản và nhận ngay mã giảm giá cho vé đầu tiên.",
      },
      {
        "title": "Tặng combo bắp nước cho sinh nhật khách hàng",
        "desc": "Áp dụng trong tuần sinh nhật, chỉ cần mang CMND hoặc CCCD.",
      },
      {
        "title": "Tặng vé miễn phí cho khách hàng thân thiết",
        "desc": "Thành viên tích đủ 10 vé sẽ được tặng 1 vé xem phim bất kỳ.",
      },
      {
        "title": "Giảm 20% khi thanh toán bằng thẻ ngân hàng đối tác",
        "desc": "Áp dụng cho các thẻ Visa/MasterCard của ngân hàng liên kết.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔴 THANH TIÊU ĐỀ CÓ NÚT QUAY LẠI
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 12,
            ),
            color: Colors.red.shade700,
            child: Row(
              children: [
                // 🔙 Nút quay lại
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // 👈 Quay lại trang trước đó
                  },
                ),

                // 🏷 Tiêu đề căn giữa
                const Expanded(
                  child: Center(
                    child: Text(
                      "ƯU ĐÃI VÀ QUÀ TẶNG",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 48), // giữ tiêu đề chính giữa
              ],
            ),
          ),

          // 🎁 DANH SÁCH QUÀ TẶNG
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
                  elevation: 3,
                  shadowColor: Colors.black.withOpacity(0.1),
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
                        style: const TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ),
                    trailing: const Icon(Icons.card_giftcard, color: Colors.redAccent),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
