import 'package:flutter/material.dart';

class FinancialSummaryRow extends StatelessWidget {
  const FinancialSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: FinancialBox(title: "Revenue by year", value: "\$23", change: "-4.8%")),
        SizedBox(width: 12),
        Expanded(child: FinancialBox(title: "Revenue by month", value: "\$23", change: "+10%")),
        SizedBox(width: 12),
        Expanded(child: FinancialBox(title: "Daily income", value: "\$12.34", change: "-4.2%")),
        SizedBox(width: 12),
        Expanded(child: FinancialBox(title: "Expense current", value: "\$31.53", change: "+8.1%")),
      ],
    );
  }
}

class FinancialBox extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const FinancialBox({
    required this.title,
    required this.value,
    required this.change,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change.contains("+");
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              color: isPositive ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
