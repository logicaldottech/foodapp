import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class CabServiceCard extends StatelessWidget {
  const CabServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Cab Sharing",
      hindi: "Nearby logo ke sath cab share karke travel karein",
      details: "Cost-saving cab sharing for college, office, or market rides.",
      iconPath: "assets/services/cab.png",
      color: Color(0xFFD1C4E9),
      isLive: false,
    );
  }
}
