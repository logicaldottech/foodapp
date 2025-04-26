import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanControlsSection extends StatelessWidget {
  final VoidCallback onPause;
  final VoidCallback onExtend;
  final VoidCallback onViewAll;

  const PlanControlsSection({
    super.key,
    required this.onPause,
    required this.onExtend,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff6FCF97);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Plan Controls"),
          const SizedBox(height: 8),
          _sectionSubtitle("Manage your subscription below"),
          const SizedBox(height: 18),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              _actionButton(
                icon: Icons.pause_circle_outline,
                label: "Pause Plan",
                onPressed: onPause,
                isFilled: true,
                color: primary,
              ),
              _actionButton(
                icon: Icons.event_repeat,
                label: "Extend Plan",
                onPressed: onExtend,
                color: primary,
              ),
              _actionButton(
                icon: Icons.calendar_today_outlined,
                label: "View All Meals",
                onPressed: onViewAll,
                color: primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );

  Widget _sectionSubtitle(String text) => Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      );

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    bool isFilled = false,
  }) {
    final style = isFilled
        ? ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )
        : OutlinedButton.styleFrom(
            foregroundColor: color,
            side: BorderSide(color: color),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          );

    return isFilled
        ? ElevatedButton.icon(onPressed: onPressed, icon: Icon(icon), label: Text(label), style: style)
        : OutlinedButton.icon(onPressed: onPressed, icon: Icon(icon), label: Text(label), style: style);
  }

  BoxDecoration _cardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
      ],
    );
  }
}
