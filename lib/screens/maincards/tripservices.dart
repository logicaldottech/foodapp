import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class TripServiceCard extends StatelessWidget {
  const TripServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Trip Planning",
      hindi: "Trip plan karna, booking aur itinerary tayar karna",
      details:
          "Plan vacations, weekend trips, college travel, and get all support in one place.",
      iconPath: "assets/services/trip.png",
      color: Color(0xFFFFEBEE),
      isLive: false,
    );
  }
}
