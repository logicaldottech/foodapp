import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'step1_choose_duration.dart';

class SubscriptionPlanDetailPage extends StatefulWidget {
  final String title;
  final int price;
  final List<String> includes;
  final String deliveryTime;
  final String info;

  const SubscriptionPlanDetailPage({
    super.key,
    required this.title,
    required this.price,
    required this.includes,
    required this.deliveryTime,
    required this.info,
  });

  @override
  State<SubscriptionPlanDetailPage> createState() => _SubscriptionPlanDetailPageState();
}

class _SubscriptionPlanDetailPageState extends State<SubscriptionPlanDetailPage> {
  final List<String> selectedAddons = [];

  final Map<String, Map<String, dynamic>> addons = {
    'Salad': {'price': 10, 'icon': Icons.grass},
    'Curd': {'price': 15, 'icon': Icons.icecream},
    'Dessert': {'price': 20, 'icon': Icons.cake},
  };

  final int originalPrice = 2999;

  @override
  Widget build(BuildContext context) {
    final int discount = originalPrice - widget.price;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1ChooseDuration()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFA8E6CF), Color(0xFF2E7D32)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Subscribe Now",
                          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add to Cart",
                          style: GoogleFonts.poppins(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          // 🖼 Hero
          Stack(
            children: [
              Image.asset("assets/images/1.png", width: double.infinity, height: 220, fit: BoxFit.cover),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Veg",
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text("4.8 | 1250 Reviews", style: GoogleFonts.poppins(fontSize: 13)),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Text("₹${widget.price}", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green.shade800)),
                    const SizedBox(width: 10),
                    Text("₹$originalPrice", style: GoogleFonts.poppins(decoration: TextDecoration.lineThrough, color: Colors.redAccent)),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("You Save ₹$discount", style: GoogleFonts.poppins(fontSize: 12, color: Colors.red.shade700)),
                ),

                const SizedBox(height: 20),

                Text("About this Plan", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(widget.info, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    IconLabel(icon: Icons.clean_hands, label: "Hygienic"),
                    IconLabel(icon: Icons.home, label: "Home-style"),
                    IconLabel(icon: Icons.no_food, label: "No Preservatives"),
                  ],
                ),

                const SizedBox(height: 30),

                Text("Make it Better with Add-Ons", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed: () => _showAddOnModal(context),
                  icon: const Icon(Icons.add),
                  label: Text("Choose Add-Ons", style: GoogleFonts.poppins(fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    foregroundColor: Colors.green.shade900,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),

                if (selectedAddons.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: selectedAddons.map((addon) {
                      return Chip(
                        label: Text(addon, style: GoogleFonts.poppins(fontSize: 13)),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => setState(() => selectedAddons.remove(addon)),
                        backgroundColor: Colors.green.shade50,
                      );
                    }).toList(),
                  )
                ],

                const SizedBox(height: 30),

                Text("What Our Customers Say", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                ReviewCard(name: "Riya", rating: 5, comment: "Best meal subscription I’ve used so far! So fresh."),
                ReviewCard(name: "Arjun", rating: 4, comment: "Loved the home-style taste. Great for daily meals."),
                TextButton(
                  onPressed: () {},
                  child: Text("View All Reviews", style: GoogleFonts.poppins(color: Colors.green.shade700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddOnModal(BuildContext context) {
    final tempSelected = [...selectedAddons];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose Add-Ons", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...addons.entries.map((entry) {
              final addon = entry.key;
              final icon = entry.value['icon'];
              final price = entry.value['price'];

              return CheckboxListTile(
                value: tempSelected.contains(addon),
                onChanged: (checked) {
                  setState(() {
                    checked!
                        ? tempSelected.add(addon)
                        : tempSelected.remove(addon);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  children: [
                    Icon(icon, color: Colors.green),
                    const SizedBox(width: 10),
                    Text("$addon (+₹$price)", style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedAddons
                    ..clear()
                    ..addAll(tempSelected);
                });
                Navigator.of(ctx).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              child: Text("Add Selected", style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// COMPONENTS
class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconLabel({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 24),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;

  const ReviewCard({super.key, required this.name, required this.rating, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
              const Spacer(),
              Row(
                children: List.generate(
                  rating,
                  (_) => const Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(comment, style: GoogleFonts.poppins(fontSize: 13)),
        ],
      ),
    );
  }
}