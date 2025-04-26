import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanSummaryCard extends StatelessWidget {
  final int daysRemaining;
  final int totalDays;

  const PlanSummaryCard({
    super.key,
    required this.daysRemaining,
    this.totalDays = 15,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (1 - (daysRemaining / totalDays)).clamp(0.0, 1.0);
    const primary = Color(0xff6FCF97);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _planHeader(primary),
          const SizedBox(height: 18),
          _infoRow("📅", "Apr 10 – Apr 24"),
          const SizedBox(height: 8),
          _infoRow("🕒", "Delivery: 1:00 – 2:00 PM"),
          const SizedBox(height: 20),
          _animatedProgressBar(progress, daysRemaining, totalDays, primary),
        ],
      ),
    );
  }

  Widget _planHeader(Color primary) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text("ACTIVE PLAN",
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
        ),
        const SizedBox(width: 12),
        Text("15-Day Veg Plan",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  Widget _infoRow(String icon, String text) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Text(text,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
      ],
    );
  }

  Widget _animatedProgressBar(
      double progress, int daysLeft, int total, Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey.shade200,
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 8),
            Text("$daysLeft of $total days left",
                style: GoogleFonts.poppins(
                    fontSize: 13, color: color, fontWeight: FontWeight.w600)),
          ],
        );
      },
    );
  }
}
