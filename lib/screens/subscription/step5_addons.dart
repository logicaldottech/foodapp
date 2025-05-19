import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/screens/subscription/step6_final_summary.dart';

class Step5AddOns extends StatefulWidget {
  final String duration;
  final String deliverySlot;
  final DateTime startDate;
  final DateTime endDate;
  final bool skippingEnabled;
  final List<DateTime> skipDays;

  const Step5AddOns({
    Key? key,
    required this.duration,
    required this.deliverySlot,
    required this.startDate,
    required this.endDate,
    required this.skippingEnabled,
    required this.skipDays,
  }) : super(key: key);

  @override
  State<Step5AddOns> createState() => _Step5AddOnsState();
}

class _Step5AddOnsState extends State<Step5AddOns> {
  final List<Map<String, dynamic>> addons = [
    {
      'name': 'Salad',
      'price': 10,
      'image': 'assets/images/1.png', // ✅ Use your actual image paths
    },
    {
      'name': 'Curd',
      'price': 15,
      'image': 'assets/images/1.png',
    },
    {
      'name': 'Sweet',
      'price': 20,
      'image': 'assets/images/1.png',
    },
  ];

  final Map<String, int> selectedAddons = {};

  void _toggleAddonQuantity(String addonName, bool increase) {
    setState(() {
      if (increase) {
        selectedAddons.update(addonName, (value) => value + 1, ifAbsent: () => 1);
      } else {
        if (selectedAddons.containsKey(addonName) && selectedAddons[addonName]! > 1) {
          selectedAddons.update(addonName, (value) => value - 1);
        }
      }
    });
  }

  int _calculateTotalAddOnPrice() {
    int total = 0;
    for (var entry in selectedAddons.entries) {
      final addon = addons.firstWhere((a) => a['name'] == entry.key);
      final int price = addon['price'] as int;
      total += price * entry.value;
    }
    return total;
  }

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Step6FinalSummary(
          duration: widget.duration,
          deliverySlot: widget.deliverySlot,
          startDate: widget.startDate,
          endDate: widget.endDate,
          skippingEnabled: widget.skippingEnabled,
          skipDays: widget.skipDays,
          selectedAddons: selectedAddons,
        ),
      ),
    );
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
          "Would You Like to Add Extras?",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                "Boost your meals with optional sides.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: addons.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final addon = addons[index];
                  final quantity = selectedAddons[addon['name']] ?? 0;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.teal.shade100,
                          backgroundImage: AssetImage(addon['image']), // ✅ Real image
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addon['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${addon['price']}/day",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _quantityButton(addon['name'], false),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                quantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _quantityButton(addon['name'], true),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (selectedAddons.isNotEmpty) _buildSelectedSummary(),
            const SizedBox(height: 8),
          ],
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
            onTap: _onNextPressed,
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
                  "Next",
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

  Widget _quantityButton(String addonName, bool increment) {
    return InkWell(
      onTap: () => _toggleAddonQuantity(addonName, increment),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Icon(
          increment ? Icons.add : Icons.remove,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildSelectedSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedAddons.entries.map((entry) {
              return Chip(
                label: Text("${entry.key} ×${entry.value}"),
                backgroundColor: Colors.teal.shade100,
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Total Add-Ons Price: ₹${_calculateTotalAddOnPrice()}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
