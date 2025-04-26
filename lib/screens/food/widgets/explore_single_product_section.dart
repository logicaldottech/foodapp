import 'package:flutter/material.dart';
import 'explore_product_card.dart';
import 'explore_section_title.dart';

class ExploreSingleProductSection extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Color primary;

  const ExploreSingleProductSection({super.key, required this.products, required this.primary});

  @override
  Widget build(BuildContext context) {
    final singles = products.where((e) => e['type'] == 'Single Product').toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ExploreSectionTitle(title: "🟡 Single Products"),
        ...singles.map((e) => ExploreProductCard(item: e, primary: primary)).toList(),
      ],
    );
  }
}
