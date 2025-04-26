import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'subscription_plan_detail_page.dart';

class SubscriptionPlanListingPage extends StatefulWidget {
  const SubscriptionPlanListingPage({super.key});

  @override
  State<SubscriptionPlanListingPage> createState() => _SubscriptionPlanListingPageState();
}

class _SubscriptionPlanListingPageState extends State<SubscriptionPlanListingPage> {
  int selectedTab = 1;
  int _currentBanner = 0;

  final List<String> banners = [
    'assets/images/banner.png',
    'assets/images/banner.png',
    'assets/images/banner.png',
  ];

  final List<String> tabLabels = [
    "7 Days",
    "15 Days",
    "30 Days",
    "45 Days",
    "60 Days",
    "Custom",
    "Keto",
    "Balanced",
  ];

  final List<Map<String, dynamic>> plans = [
    {
      'title': '15-Day Veg Plan',
      'desc': 'Delicious vegetarian meals delivered daily',
      'price': '₹1799',
      'originalPrice': '₹1999', // 🔥 Discounted
      'rating': 4.8,
      'reviews': 1203,
      'tags': ['Veg'],
      'image': 'assets/images/1.png',
    },
    {
      'title': '30-Day Jain Plan',
      'desc': 'Nutritious Jain meals carefully prepared',
      'price': '₹3599',
      'rating': 4.6,
      'reviews': 888,
      'tags': ['Jain'],
      'image': 'assets/images/1.png',
    },
    {
      'title': '7-Day Trial Plan',
      'desc': 'Great to try us before subscribing',
      'price': '₹999',
      'rating': 4.4,
      'reviews': 503,
      'tags': ['Trial'],
      'image': 'assets/images/1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: ListView(
          children: [
            // 🖼 Banner
            SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: banners.length,
                onPageChanged: (i) => setState(() => _currentBanner = i),
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(banners[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // 🔘 Dots
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentBanner == index ? Colors.orange : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),

            // 🌿 Tabs
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(tabLabels.length, (index) {
                    final isSelected = selectedTab == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedTab = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(colors: [Color(0xFFB2DFDB), Color(0xFF80CBC4)])
                              : const LinearGradient(colors: [Colors.white, Colors.white]),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: isSelected
                              ? [BoxShadow(color: Colors.teal.withOpacity(0.2), blurRadius: 8, offset: Offset(0, 4))]
                              : [],
                          border: Border.all(
                            color: isSelected ? Colors.transparent : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          tabLabels[index],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // 🧾 Plan Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(plans.length, (index) {
                  final plan = plans[index];
                  final hasDiscount = plan.containsKey('originalPrice');

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 🍱 Image
                          SizedBox(
                            width: 110,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    plan['image'],
                                    height: 130,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      plan['tags'][0],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),

                          // 📋 Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(plan['title'],
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text(plan['desc'],
                                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade700)),

                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      plan['price'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.green.shade800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (hasDiscount) ...[
                                      const SizedBox(width: 8),
                                      Text(
                                        plan['originalPrice'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.red.shade300,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                                if (hasDiscount)
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Save ₹${int.parse(plan['originalPrice'].replaceAll(RegExp(r'[^\d]'), '')) - int.parse(plan['price'].replaceAll(RegExp(r'[^\d]'), ''))}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: Colors.red.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text("${plan['rating']} ",
                                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                                    Text("(${plan['reviews']} reviews)",
                                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                GradientViewDetailsButton(
                                  onPressed: () {
                                    Navigator.of(context).push(_createRoute(plan));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(Map<String, dynamic> plan) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SubscriptionPlanDetailPage(
            title: plan['title'],
            price: int.parse(plan['price'].replaceAll(RegExp(r'[^\d]'), '')),
            includes: List<String>.from(plan['tags']),
            deliveryTime: "1:00 PM – 2:00 PM",
            info: plan['desc'],
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}

// ✅ FINAL GREEN GRADIENT BUTTON
class GradientViewDetailsButton extends StatefulWidget {
  final VoidCallback onPressed;
  const GradientViewDetailsButton({super.key, required this.onPressed});

  @override
  State<GradientViewDetailsButton> createState() => _GradientViewDetailsButtonState();
}

class _GradientViewDetailsButtonState extends State<GradientViewDetailsButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arrowOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _arrowOffset = Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    if (hovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFA8E6CF), Color(0xFF2E7D32)], // 🌿 Mint to Green
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "View Details",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              AnimatedBuilder(
                animation: _arrowOffset,
                builder: (context, child) => Transform.translate(
                  offset: Offset(_arrowOffset.value, 0),
                  child: child,
                ),
                child: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
