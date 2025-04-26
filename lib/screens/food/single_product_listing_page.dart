import 'package:flutter/material.dart';

class Product {
  final String title;
  final int price;

  Product({required this.title, required this.price});
}

class SingleProductListingPage extends StatefulWidget {
  const SingleProductListingPage({Key? key}) : super(key: key);

  @override
  State<SingleProductListingPage> createState() => _SingleProductListingPageState();
}

class _SingleProductListingPageState extends State<SingleProductListingPage> {
  final List<Product> _allProducts = [
    Product(title: 'Roti Pack', price: 20),
    Product(title: 'Curd Bowl', price: 15),
    Product(title: 'Ladoo Box', price: 40),
    // Add more products here 🔥
  ];

  List<Product> _filteredProducts = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add-ons & Sides"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: ListTile(
                      title: Text(product.title),
                      subtitle: Text('₹${product.price}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart 🛒'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
