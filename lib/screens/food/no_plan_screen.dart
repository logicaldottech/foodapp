import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'explore_food_screen.dart'; // ✅ adjust if in different folder

class NoActivePlanScreen extends StatelessWidget {
  const NoActivePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff6FCF97);

    return Scaffold(
      backgroundColor: const Color(0xffF4F9F5),
      appBar: AppBar(
        title: Text(
          "Food Dashboard",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        backgroundColor: primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🍽️ Friendly Emoji or animation
              const Text("🍽️", style: TextStyle(fontSize: 72)),

              const SizedBox(height: 20),

              Text(
                "No Active Plan Found",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff1A1A1A)),
              ),

              const SizedBox(height: 12),

              Text(
                "Looks like you haven't subscribed to a meal plan yet.\nLet’s explore your delicious options!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExploreFoodScreen(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xff6FCF97), Color(0xff56CCF2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    "Explore Our Food",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
