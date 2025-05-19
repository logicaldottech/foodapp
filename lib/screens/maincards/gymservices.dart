import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class GymServiceCard extends StatelessWidget {
  const GymServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Gym",
      hindi: "Daily workout ke liye gym options aur tips",
      details:
          "Discover local gyms, fitness routines, and basic at-home plans.",
      iconPath: "assets/services/gym.png",
      color: Color(0xFFF3E5F5),
      isLive: false,
    );
  }
}
