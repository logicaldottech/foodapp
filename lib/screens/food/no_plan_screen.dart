import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'explore_food_screen.dart';

class NoActivePlanScreen extends StatelessWidget {
  const NoActivePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xff7C3AED);
    const background = Color(0xffF3F4F6);

    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          // 🌈 Gradient background at top
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff7F00FF), Color(0xff00FF87)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // 🧾 AppBar text style header
                  Text(
                    "Food Dashboard",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🧊 Card-style info section
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text("🍽️", style: TextStyle(fontSize: 72)),
                        const SizedBox(height: 20),

                        Text(
                          "No Active Plan Found",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1A1A1A),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "You haven’t subscribed to a meal plan yet.\nLet’s explore your delicious options!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 32),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExploreFoodScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: primaryPurple,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            "Explore Our Food",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
