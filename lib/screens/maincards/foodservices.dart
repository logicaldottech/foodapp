import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/screens/food/no_plan_screen.dart';

class FoodServiceCard extends StatelessWidget {
  const FoodServiceCard({super.key});

  Future<bool> checkFoodSubscription() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final subscribed = await checkFoodSubscription();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => subscribed
                ? const NoActivePlanScreen()
                : const NoActivePlanScreen(),
          ),
        );
      },
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          color: const Color(0xffFF7043),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge, // clip image overflow
          children: [
            // 🍱 Image - stick to edge, not inside padding
            Align(
              alignment: Alignment.bottomRight,
              child: ClipRect(
                child: Transform.translate(
                  offset: const Offset(30, 30), // push outside bounds
                  child: Image.asset(
                    "assets/images/food_bd.png",
                    height: 105,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // 📝 Text + Arrow - inside padding
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Food",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Ghar jaise swad — no oily,\nno problem if you eat every day.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
