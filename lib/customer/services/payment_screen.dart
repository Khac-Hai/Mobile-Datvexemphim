import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datvexemphim/customer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:datvexemphim/customer/models/ticket_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr.dart';

class PaymentScreen extends StatefulWidget {
  final String cinema;
  final String movie;
  final String timeSlot;
  final List<String> seats;

  const PaymentScreen({
    super.key,
    required this.cinema,
    required this.movie,
    required this.timeSlot,
    required this.seats,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  /// phương thức thanh toán
  String selectedMethod = "noidia";

  /// combo
  Map<String, Map<String, dynamic>> combos = {
    "Combo Bắp + Coca": {
      "price": 70000,
      "qty": 0,
      "img": "https://iguov8nhvyobj.vcdn.cloud/media/concession/web/6465deb2716d7_1684397746.png"
    },
    "Combo Bắp lớn + 2 Coca": {
      "price": 100000,
      "qty": 0,
      "img": "https://iguov8nhvyobj.vcdn.cloud/media/concession/web/6644731d5a8f5_1715761949.png"
    },
    "Combo Bắp + Pepsi": {
      "price": 65000,
      "qty": 0,
      "img": "https://iguov8nhvyobj.vcdn.cloud/media/concession/web/68398554b9635_1748600149.png"
    },
  };

  /// lưu ghế đã đặt
  Future<void> _markSeatsAsBooked() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${widget.movie}_${widget.cinema}_${widget.timeSlot}';
    final saved = prefs.getStringList(key) ?? [];

    saved.addAll(widget.seats);

    await prefs.setStringList(key, saved.toSet().toList());
  }

  /// lưu firebase
  Future<void> _saveTicketToFirebase(Ticket ticket) async {

    Map<String, Map<String, dynamic>> selectedCombos = {};

    combos.forEach((key, value) {
      if (value["qty"] > 0) {
        selectedCombos[key] = {
          "qty": value["qty"],
          "price": value["price"]
        };
      }
    });

    await FirebaseFirestore.instance.collection('tickets').add({
      'movie': ticket.movie,
      'cinema': ticket.cinema,
      'timeSlot': ticket.timeSlot,
      'seats': ticket.seats,
      'combos': selectedCombos,
      'paymentMethod': selectedMethod,
      'total': ticket.total,
      'date': ticket.date.toIso8601String(),
    });
  }

  /// dialog thành công
  void _showSuccessDialog(int total) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 90,
                ),

                const SizedBox(height: 15),

                const Text(
                  "Thanh toán thành công",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(140, 45),
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
            ),
          ),
        );

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    const int seatPrice = 50000;

    int comboPrice = 0;

    combos.forEach((key, value) {
      comboPrice += (value["price"] as int) * (value["qty"] as int);
    });

    final int seatTotal = seatPrice * widget.seats.length;

    final int total = seatTotal + comboPrice;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Thanh toán",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// thông tin phim
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Rạp: ${widget.cinema}"),
                  Text("Thời gian: ${widget.timeSlot}"),
                  Text("Ghế: ${widget.seats.join(", ")}"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// combo
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "COMBO ƯU ĐÃI LỚN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: combos.entries.map((combo) {
                  return _buildComboItem(
                    combo.key,
                    combo.value["price"],
                    combo.value["img"],
                  );
                }).toList(),
              ),
            ),

            /// PHƯƠNG THỨC THANH TOÁN
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phương thức thanh toán",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            _paymentButton(
              "Thẻ nội địa (ATM)",
              "noidia",
              Icons.credit_card,
            ),

            const SizedBox(height: 8),

            _paymentButton(
              "Thẻ quốc tế (Visa / Master)",
              "quocte",
              Icons.public,
            ),

            const SizedBox(height: 8),

            _paymentButton(
              "Thanh toán QR Code",
              "qr",
              Icons.qr_code,
            ),

            const SizedBox(height: 10),

            const SizedBox(height: 10),
            /// tổng tiền
            Column(
              children: [
                _priceRow("Tiền ghế", seatTotal),
                _priceRow("Tiền combo", comboPrice),
                const Divider(),
                _priceRow("Tổng", total, bold: true),
              ],
            ),

            const SizedBox(height: 15),

            /// nút thanh toán
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize:
                const Size(double.infinity, 50),
              ),
    onPressed: () async {

    if (selectedMethod == "qr") {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => QRPaymentScreen(total: total),
    ),
    );

    return;
    }

    final ticket = Ticket(
    movie: widget.movie,
    cinema: widget.cinema,
    timeSlot: widget.timeSlot,
    seats: widget.seats,
    total: total,
    date: DateTime.now(),
    );

    await _saveTicketToFirebase(ticket);
    await _markSeatsAsBooked();
    _showSuccessDialog(total);
    },
              child: const Text(
                "Thanh toán",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// combo widget
  Widget _buildComboItem(
      String name,
      int price,
      String img) {

    int qty = combos[name]!["qty"];

    return Card(
      child: ListTile(
        leading: Image.network(img, width: 50),
        title: Text(name),
        subtitle: Text("$price VND"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (qty > 0) {
                  setState(() {
                    combos[name]!["qty"]--;
                  });
                }
              },
            ),

            Text(qty.toString()),

            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  combos[name]!["qty"]++;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// payment button
  Widget _paymentButton(
      String title,
      String method,
      IconData icon) {

    bool selected = selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? Colors.red.shade50
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? Colors.red
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [

            Icon(icon,
                color: selected
                    ? Colors.red
                    : Colors.grey),

            const SizedBox(width: 10),

            Expanded(child: Text(title)),

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? Colors.red
                  : Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget _priceRow(
      String title,
      int price,
      {bool bold = false}) {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: bold
                    ? FontWeight.bold
                    : FontWeight.normal)),
        Text("$price VND",
            style: TextStyle(
                fontWeight: bold
                    ? FontWeight.bold
                    : FontWeight.normal)),
      ],
    );
  }
}