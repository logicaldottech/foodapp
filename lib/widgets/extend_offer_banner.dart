import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExtendOfferBanner extends StatelessWidget {
  const ExtendOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xfffff3e0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text("Extend your plan now and get 2 meals free!",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
