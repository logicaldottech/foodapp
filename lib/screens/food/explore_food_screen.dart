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

  final Color background = const Color(0xffF3F4F6);
  final Color gradientStart = const Color(0xff7F00FF);
  final Color gradientEnd = const Color(0xff00FF87);

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
      backgroundColor: background,
      body: CustomScrollView(
        slivers: [
          // ✅ SliverAppBar — compact & fixed with no extra gap
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 60,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradientStart, gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Explore Our Food",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.notifications_none_rounded,
                                  color: Colors.white, size: 24),
                              SizedBox(width: 16),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ✅ Scrollable Sections
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const ExploreSearchBar(),
                  const SizedBox(height: 16),
                  const ExploreBanner(),
                  const SizedBox(height: 24),

                  ExploreRecommendedSection(
                      products: products, primary: gradientStart),
                  const SizedBox(height: 24),

                  ExploreSingleProductSection(
                      products: products, primary: gradientStart),
                  const SizedBox(height: 24),

                  ExploreMealsSection(
                      products: products, primary: gradientStart),
                  const SizedBox(height: 24),

                  ExploreSubscriptionSection(
                      products: products, primary: gradientStart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
