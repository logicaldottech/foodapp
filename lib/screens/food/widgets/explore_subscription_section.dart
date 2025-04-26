import 'package:flutter/material.dart';
import 'explore_product_card.dart';
import 'explore_section_title.dart';

class ExploreSubscriptionSection extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Color primary;

  const ExploreSubscriptionSection({super.key, required this.products, required this.primary});

  @override
  Widget build(BuildContext context) {
    final subs = products.where((e) => e['type'] == 'Subscription').toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ExploreSectionTitle(title: "🔵 Subscriptions"),
        ...subs.map((e) => ExploreProductCard(item: e, primary: primary)).toList(),
      ],
    );
  }
}
