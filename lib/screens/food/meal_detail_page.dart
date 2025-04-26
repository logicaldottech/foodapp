import 'package:flutter/material.dart';

class MealDetailPage extends StatefulWidget {
  const MealDetailPage({Key? key}) : super(key: key);

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  int quantity = 1;
  bool saladSelected = false;
  bool curdSelected = false;

  final int basePrice = 99;
  final int saladPrice = 10;
  final int curdPrice = 15;

  int calculateTotalPrice() {
    int addons = 0;
    if (saladSelected) addons += saladPrice;
    if (curdSelected) addons += curdPrice;
    return (basePrice + addons) * quantity;
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Image Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.fastfood, size: 100),
            ),
            const SizedBox(height: 16),

            // Meal Name
            const Text(
              "Rajma Chawal",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Description
            const Text(
              "Simple North Indian meal with roti, rice, dal, and sabzi.",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            // Price
            Text(
              "Base Price: ₹$basePrice",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            // Add-ons
            const Text(
              "Add-ons",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: const Text("Salad (+₹10)"),
              value: saladSelected,
              onChanged: (value) {
                setState(() {
                  saladSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Curd (+₹15)"),
              value: curdSelected,
              onChanged: (value) {
                setState(() {
                  curdSelected = value ?? false;
                });
              },
            ),

            const SizedBox(height: 16),

            // Quantity Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Quantity:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: decrementQuantity,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  "$quantity",
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: incrementQuantity,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  int total = calculateTotalPrice();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added to cart 🛒 Total: ₹$total"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text("Add to Cart – ₹${calculateTotalPrice()}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
