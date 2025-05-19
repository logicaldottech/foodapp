import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class PgFlatServiceCard extends StatelessWidget {
  const PgFlatServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "PG / Flat Support",
      hindi: "PG aur flat dhoondhne mein madad",
      details: "Search verified PGs, flats for rent, or hostel support nearby.",
      iconPath: "assets/services/pg_support.png",
      color: Color(0xFFE8F5E9),
      isLive: false,
    );
  }
}
