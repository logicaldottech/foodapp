import 'package:flutter/material.dart';
import 'package:foodapp/screens/maincards/service_card_template.dart';

class GroceryServiceCard extends StatelessWidget {
  const GroceryServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceCardTemplate(
      title: "Grocery",
      hindi: "Har din ki rashan aur kirane ki items",
      details: "Daily groceries like rice, pulses, oil, sugar, etc.",
      iconPath: "assets/services/grocery.png",
      color: Color(0xFFD7CCC8),
      isLive: false,
    );
  }
}
