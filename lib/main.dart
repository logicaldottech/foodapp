import 'package:flutter/material.dart';
import 'package:foodapp/screens/food/active_food_dashboard.dart';
import 'package:foodapp/screens/food/no_plan_screen.dart';
import 'package:foodapp/screens/subscription/subscription_plan_listing_page.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: SubscriptionPlanListingPage(),
    );
  }
}
