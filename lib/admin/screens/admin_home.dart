import 'package:flutter/material.dart';
import '../../admin/widgets/admin_sidebar.dart';
import 'dashboard/financial_summary_row.dart';
import 'dashboard/revenue_chart_section.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminSidebar(),
      appBar: AppBar(
        title: const Text("CORONA Dashboard"),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            FinancialSummaryRow(),
            SizedBox(height: 24),
            RevenueChartSection(),
          ],
        ),
      ),
    );
  }
}
