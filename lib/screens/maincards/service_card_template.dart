import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCardTemplate extends StatelessWidget {
  final String title;
  final String hindi;
  final String details;
  final String iconPath;
  final Color color;
  final bool isLive;
  final VoidCallback? onTap;

  const ServiceCardTemplate({
    super.key,
    required this.title,
    required this.hindi,
    required this.details,
    required this.iconPath,
    required this.color,
    required this.isLive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧊 Icon
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                iconPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported, size: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // Hindi
          Text(
            hindi,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Details
          Text(
            details,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.black87,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          // 🔓 View / 🔒 Lock
          Align(
            alignment: Alignment.centerRight,
            child: isLive
                ? ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        const Text("View", style: TextStyle(fontSize: 12)),
                  )
                : const Icon(Icons.lock_outline,
                    size: 20, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
