import 'package:flutter/material.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final promotions = [
      {
        "title": "🔥 Mua 1 vé tặng 1 vé",
        "desc": "Áp dụng cho các suất chiếu trước 17h, từ thứ Hai đến thứ Năm.",
      },
      {
        "title": "🍿 Combo bắp nước chỉ 49.000đ",
        "desc": "Tiết kiệm đến 30% khi mua cùng vé xem phim bất kỳ.",
      },
      {
        "title": "🎬 Giảm 20% vé xem phim 2D và 3D",
        "desc": "Dành cho học sinh, sinh viên có thẻ học sinh/sinh viên hợp lệ.",
      },
      {
        "title": "💳 Hoàn tiền 15% khi thanh toán qua MoMo",
        "desc": "Áp dụng cho giao dịch từ 100.000đ trở lên trong khung giờ 9h–21h.",
      },
      {
        "title": "🎁 Thành viên VIP – Nhận ưu đãi đặc biệt mỗi tháng",
        "desc": "Tích điểm đổi quà, nhận vé miễn phí và ưu tiên chọn ghế.",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === THANH TIÊU ĐỀ ĐỎ FULL MÀN HÌNH ===
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              bottom: 12,
            ),
            color: Colors.red,
            child: const Center(
              child: Text(
                "KHUYẾN MÃI HOT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // === DANH SÁCH KHUYẾN MÃI ===
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: promotions.length,
              itemBuilder: (context, index) {
                final promo = promotions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo["title"]!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        promo["desc"]!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
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
