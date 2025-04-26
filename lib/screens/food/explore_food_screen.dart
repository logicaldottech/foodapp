import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 🧩 Modular Widgets
import 'widgets/explore_banner.dart';
import 'widgets/explore_search_bar.dart';
import 'widgets/explore_recommended_section.dart';
import 'widgets/explore_meals_section.dart';
import 'widgets/explore_single_product_section.dart';
import 'widgets/explore_subscription_section.dart';

class ExploreFoodScreen extends StatelessWidget {
  ExploreFoodScreen({super.key});

  final Color primary = const Color(0xff6FCF97);

  final List<Map<String, dynamic>> products = [
    {
      "title": "Rajma Rice",
      "tagline": "One-time lunch meal",
      "price": "₹99",
      "type": "Meal",
      "color": Colors.green,
      "button": "View Details",
      "image": "assets/services/food.png",
      "recommended": true
    },
    {
      "title": "Curd Bowl",
      "tagline": "Add-on product",
      "price": "₹15",
      "type": "Single Product",
      "color": Colors.amber,
      "button": "Add to Cart",
      "image": "assets/services/food.png",
      "recommended": false
    },
    {
      "title": "7-Day Veg Plan",
      "tagline": "Daily lunch with custom meals",
      "price": "₹699",
      "type": "Subscription",
      "color": Colors.blue,
      "button": "Subscribe",
      "image": "assets/services/food.png",
      "recommended": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F9F5),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: Text("Explore Our Food",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ExploreSearchBar(),
          const SizedBox(height: 16),
          const ExploreBanner(),
          const SizedBox(height: 24),
          ExploreRecommendedSection(products: products, primary: primary),
          const SizedBox(height: 24),
          ExploreSingleProductSection(products: products, primary: primary),
          const SizedBox(height: 24),
          ExploreMealsSection(products: products, primary: primary),
          const SizedBox(height: 24),
          ExploreSubscriptionSection(products: products, primary: primary),
        ],
      ),
    );
  }
}
