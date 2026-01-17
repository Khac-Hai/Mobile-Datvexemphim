import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {"icon": "🎟️", "title": "THUÊ RẠP TỔ CHỨC SỰ KIỆN"},
      {"icon": "📢", "title": "QUẢNG CÁO TẠI RẠP"},
      {"icon": "🎁", "title": "MUA PHIẾU QUÀ TẶNG / E-CODE"},
      {"icon": "👥", "title": "MUA VÉ NHÓM"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // --- THANH TIÊU ĐỀ ---
          Container(
            color: Colors.red.shade700,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 8,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      "Liên hệ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // để cân đối với nút back
              ],
            ),
          ),

          // --- NỘI DUNG CHÍNH ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- ẢNH BANNER ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'lib/assets/icons/policy.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- THÔNG TIN LIÊN HỆ ---
                  const Text(
                    "· Bạn có nhu cầu quảng cáo tại màn hình cực lớn tại rạp, tiếp cận khách hàng xem phim...\n"
                        "· Bạn cần thưởng thức các bộ phim bom tấn với không gian riêng tư cùng gia đình, bạn bè, đồng nghiệp...\n"
                        "· Bạn cần địa điểm tổ chức sự kiện, họp fan, họp báo ra mắt dự án, tổ chức fan offline...\n\n"
                        "Hãy liên hệ để được hỗ trợ ngay:\n"
                        "📧 Email: ads.abc@gmail.com\n"
                        "📞 Hotline: 0333345238",
                    style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  // --- DỊCH VỤ ---
                  const Text(
                    "Dịch vụ của chúng tôi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: services.map((service) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(service["icon"]!, style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                service["title"]!,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
