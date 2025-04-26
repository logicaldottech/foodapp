import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/screens/subscription/step6_final_summary.dart'; // ✅ Import Step6

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
      'originalPrice': 15,
      'discountedPrice': 10,
      'icon': Icons.eco_rounded,
    },
    {
      'name': 'Curd',
      'originalPrice': 20,
      'discountedPrice': 15,
      'icon': Icons.local_drink_rounded,
    },
    {
      'name': 'Sweet',
      'originalPrice': 25,
      'discountedPrice': 20,
      'icon': Icons.cake_rounded,
    },
  ];

  final Map<String, int> selectedAddons = {}; // addonName : quantity

  void _toggleAddon(String addonName) {
    setState(() {
      if (selectedAddons.containsKey(addonName)) {
        selectedAddons.remove(addonName);
      } else {
        selectedAddons[addonName] = 1;
      }
    });
  }

  void _updateQuantity(String addonName, bool increment) {
    setState(() {
      if (selectedAddons.containsKey(addonName)) {
        if (increment) {
          selectedAddons[addonName] = selectedAddons[addonName]! + 1;
        } else if (selectedAddons[addonName]! > 1) {
          selectedAddons[addonName] = selectedAddons[addonName]! - 1;
        }
      }
    });
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
          "Would You Like to Add These?",
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
                "You can enhance your plan by adding extra items (Optional).",
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
                  final isSelected = selectedAddons.containsKey(addon['name']);
                  final quantity = selectedAddons[addon['name']] ?? 1;

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade300,
                        width: 2,
                      ),
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
                        Row(
                          children: [
                            Icon(
                              addon['icon'],
                              size: 30,
                              color: Colors.teal,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                addon['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Checkbox(
                              value: isSelected,
                              onChanged: (value) => _toggleAddon(addon['name']),
                              activeColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "₹${addon['originalPrice']}/day",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "₹${addon['discountedPrice']}/day",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (isSelected)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildQuantityButton(addon['name'], false),
                              const SizedBox(width: 16),
                              Text(
                                "$quantity",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 16),
                              _buildQuantityButton(addon['name'], true),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
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

  Widget _buildQuantityButton(String addonName, bool increment) {
    return InkWell(
      onTap: () => _updateQuantity(addonName, increment),
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
}
