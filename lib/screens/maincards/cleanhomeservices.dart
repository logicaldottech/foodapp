import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class CleanHomeServiceCard extends StatelessWidget {
  const CleanHomeServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Clean Home",
      hindi: "Safai, jhaadu, pochha, aur dusting",
      details: "Book professionals for deep home cleaning.",
      iconPath: "assets/services/clean_home.png",
      color: Color(0xFFFFF9C4),
      isLive: false,
    );
  }
}
