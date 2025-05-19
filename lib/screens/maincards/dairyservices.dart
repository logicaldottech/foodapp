import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DairyServiceCard extends StatelessWidget {
  const DairyServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Add navigation or feature screen
      },
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          color: const Color(0xFFE1F5FE), // 🥛 Soft blue dairy tone
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // 🧀 Image - bottom right, outside padding
            Align(
              alignment: Alignment.bottomRight,
              child: ClipRect(
                child: Transform.translate(
                  offset: const Offset(30, 30),
                  child: Image.asset(
                    "assets/services/food.png",
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // 🧾 Text content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dairy Products",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Doodh, dahi, paneer jaise dairy samaan",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: Colors.black87),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
