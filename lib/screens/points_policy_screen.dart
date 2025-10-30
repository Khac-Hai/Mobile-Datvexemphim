import 'package:flutter/material.dart';

class PointsPolicyScreen extends StatelessWidget {
  const PointsPolicyScreen({super.key});

  static const int vndPerPoint = 1000; // 1 điểm = 1.000 VND (mẫu)
  static const int pointsToRedeem = 100; // 100 điểm quy đổi
  static const int redeemValueVnd = 10000; // 100 điểm = 10.000 VND

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chính sách tích điểm'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('1. Giới thiệu'),
              const Text(
                'Chương trình tích điểm dành cho khách hàng thân thiết. '
                    'Điểm tích lũy dùng để quy đổi thành ưu đãi, phiếu giảm giá hoặc dịch vụ miễn phí theo quy định.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),

              _sectionTitle('2. Cách nhận điểm'),
              const Text(
                '- Khách hàng nhận 1 điểm cho mỗi 1.000 VND chi tiêu tại rạp (ví dụ: mua vé, bắp nước, hàng hoá).\n'
                    '- Điểm không áp dụng cho các khoản thanh toán đã được giảm giá đặc biệt (ví dụ voucher khuyến mãi), trừ khi có quy định khác.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),

              _sectionTitle('3. Mức quy đổi & Ví dụ'),
              _buildRedeemCard(),
              const SizedBox(height: 16),

              _sectionTitle('4. Hạng thành viên (mẫu)'),
              const SizedBox(height: 8),
              // ✅ Sửa lỗi layout bằng cách cho phép cuộn ngang:
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Hạng')),
                    DataColumn(label: Text('Điều kiện')),
                    DataColumn(label: Text('Ưu đãi')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Silver')),
                      DataCell(Text('Từ 0 - 999 điểm')),
                      DataCell(Text('Ưu đãi cơ bản')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Gold')),
                      DataCell(Text('Từ 1.000 - 4.999 điểm')),
                      DataCell(Text('Tặng thêm 5% điểm thưởng')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Platinum')),
                      DataCell(Text('Từ 5.000 điểm trở lên')),
                      DataCell(Text('Ưu đãi đặc quyền + quà sinh nhật')),
                    ]),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _sectionTitle('5. Thời hạn điểm'),
              const Text(
                'Mỗi điểm có thời hạn 12 tháng kể từ ngày phát sinh. '
                    'Nếu điểm không được sử dụng trong thời hạn này, điểm sẽ tự động hết hạn.',
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 16),
              _sectionTitle('6. Quy tắc sử dụng & Hủy'),
              const Text(
                '- Điểm chỉ được dùng bởi chủ tài khoản và không được chuyển nhượng.\n'
                    '- Trong trường hợp phát hiện gian lận, chương trình có quyền huỷ điểm và / hoặc khoá tài khoản.\n'
                    '- Khi xoá tài khoản, điểm tích lũy sẽ bị xoá theo chính sách của hệ thống.',
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 16),
              _sectionTitle('7. Cách kiểm tra điểm & Liên hệ'),
              const Text(
                '- Kiểm tra điểm trong mục "Tài khoản" hoặc "Lịch sử giao dịch" trong ứng dụng.\n'
                    '- Mọi thắc mắc liên hệ: hotline 1900-xxx-xxx hoặc email support@example.com',
                style: TextStyle(fontSize: 14),
              ),



              const SizedBox(height: 32),
              const Center(
                child: Text(
                  '© 2025 — Chính sách mẫu. Vui lòng chỉnh sửa trước khi đưa vào sản phẩm.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRedeemCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quy tắc quy đổi (mẫu):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('• 1 điểm = $vndPerPoint VND'),
            Text('• $pointsToRedeem điểm = $redeemValueVnd VND (phiếu giảm giá)'),
            const SizedBox(height: 8),
            const Text('Ví dụ:'),
            const SizedBox(height: 4),
            Text(
                '• Nếu bạn chi tiêu 120.000 VND → bạn được ${(120000 / vndPerPoint).floor()} điểm.'),
            Text(
                '• Nếu bạn có 250 điểm → có thể quy đổi ${(250 ~/ pointsToRedeem)} phiếu, còn ${250 % pointsToRedeem} điểm tồn.'),
          ],
        ),
      ),
    );
  }
}
