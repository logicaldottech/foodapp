import 'package:flutter/material.dart';

class SingleProductDetailPage extends StatefulWidget {
  final String name;
  final String description;
  final int price;
  final String? imageUrl; // Optional image support

  const SingleProductDetailPage({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<SingleProductDetailPage> createState() => _SingleProductDetailPageState();
}

class _SingleProductDetailPageState extends State<SingleProductDetailPage> {
  int quantity = 1;

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

  int get totalPrice => widget.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                image: widget.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(widget.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: widget.imageUrl == null
                  ? const Icon(Icons.image, size: 100, color: Colors.grey)
                  : null,
            ),

            const SizedBox(height: 16),

            // Product Name
            Text(
              widget.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              widget.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            // Price
            Text(
              "₹${widget.price}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 24),

            // Quantity Selector
            Row(
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "${widget.name} x$quantity added to cart – ₹$totalPrice 🛒"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text("Add to Cart – ₹$totalPrice"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
