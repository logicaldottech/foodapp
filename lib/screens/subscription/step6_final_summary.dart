import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step6FinalSummary extends StatefulWidget {
  final String duration;
  final String deliverySlot;
  final DateTime startDate;
  final DateTime endDate;
  final bool skippingEnabled;
  final List<DateTime> skipDays;
  final Map<String, int> selectedAddons; // addonName : quantity

  const Step6FinalSummary({
    Key? key,
    required this.duration,
    required this.deliverySlot,
    required this.startDate,
    required this.endDate,
    required this.skippingEnabled,
    required this.skipDays,
    required this.selectedAddons,
  }) : super(key: key);

  @override
  State<Step6FinalSummary> createState() => _Step6FinalSummaryState();
}

class _Step6FinalSummaryState extends State<Step6FinalSummary> {
  final TextEditingController _couponController = TextEditingController();

  void _onProceedToPay() {
    // Proceed to payment screen
    // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Review Your Subscription",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "📋 Please review your plan before proceeding to payment.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSummaryCard(),
                const SizedBox(height: 24),
                _buildAddonsSection(),
                const SizedBox(height: 24),
                _buildSkippingInfo(),
                const SizedBox(height: 24),
                _buildCouponSection(),
                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: InkWell(
            onTap: _onProceedToPay,
            borderRadius: BorderRadius.circular(30),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Proceed to Pay",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow("Duration", widget.duration),
          const Divider(),
          _buildSummaryRow("Start Date", "${widget.startDate.day} ${_monthName(widget.startDate.month)}"),
          const Divider(),
          _buildSummaryRow("Delivery Slot", widget.deliverySlot),
          const Divider(),
          _buildSummaryRow("Total Price", "₹699", bold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: bold ? 18 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add-ons Selected",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (widget.selectedAddons.isEmpty)
          Text(
            "No Add-ons Selected",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black54,
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedAddons.entries.map((e) {
              return Chip(
                label: Text(
                  "${e.key} ×${e.value}",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                backgroundColor: Colors.teal.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSkippingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Skipping Information",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.skippingEnabled
              ? "Skipping: Enabled (Up to 5 days can be skipped)"
              : "Skipping: Not Enabled",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCouponSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Coupon Code",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _couponController,
                decoration: InputDecoration(
                  hintText: "Enter Coupon Code",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                // Apply coupon logic
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: Colors.teal,
              ),
              child: const Text(
                "Apply",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _monthName(int monthNumber) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[monthNumber - 1];
  }
}
