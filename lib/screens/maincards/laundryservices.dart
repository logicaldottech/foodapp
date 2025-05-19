import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class LaundryServiceCard extends StatelessWidget {
  const LaundryServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Laundry",
      hindi: "Kapdon ki dhulai aur ironing service",
      details: "Hassle-free laundry pickup and drop.",
      iconPath: "assets/services/laundry.png",
      color: Color(0xFFE0F7FA),
      isLive: false,
    );
  }
}
