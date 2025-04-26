import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackSection extends StatelessWidget {
  final VoidCallback onRate;
  final VoidCallback onHelp;

  const FeedbackSection({
    super.key,
    required this.onRate,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff6FCF97);
    const bg = Color(0xffF0FFF6); // upgraded softer green

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _heading("Was your meal satisfying?"),
          const SizedBox(height: 6),
          Text(
            "We’d love your feedback or to help with any issue you faced today.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),

          // Primary CTA button (visually dominant)
          GestureDetector(
            onTap: onRate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
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
              child: Center(
                child: Text(
                  "⭐ Rate Today’s Meal",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Secondary link (text only)
          TextButton(
            onPressed: onHelp,
            style: TextButton.styleFrom(
              foregroundColor: Colors.black87,
              textStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            child: const Text("Need Help? Contact Us"),
          )
        ],
      ),
    );
  }

  Widget _heading(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: const Color(0xff1A1A1A),
      ),
      textAlign: TextAlign.center,
    );
  }
}
