import 'package:flutter/material.dart';
import 'explore_product_card.dart';
import 'explore_section_title.dart';

class ExploreMealsSection extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Color primary;

  const ExploreMealsSection({super.key, required this.products, required this.primary});

  @override
  Widget build(BuildContext context) {
    final meals = products.where((e) => e['type'] == 'Meal').toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ExploreSectionTitle(title: "🟢 Meals"),
        ...meals.map((e) => ExploreProductCard(item: e, primary: primary)).toList()
      ],
    );
  }
}
