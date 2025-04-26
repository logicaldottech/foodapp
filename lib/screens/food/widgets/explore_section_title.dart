import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreSectionTitle extends StatelessWidget {
  final String title;
  const ExploreSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
