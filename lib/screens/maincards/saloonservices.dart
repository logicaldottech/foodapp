import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class SaloonServiceCard extends StatelessWidget {
  const SaloonServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Saloon / Self-Care",
      hindi: "Haircut, grooming, aur beauty services ghar par",
      details: "Saloon-at-home or pre-booked visits. Unisex care options.",
      iconPath: "assets/services/saloon.png",
      color: Color(0xFFFBE9E7),
      isLive: false,
    );
  }
}
