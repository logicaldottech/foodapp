import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/plan_summary_card.dart';
import '../../widgets/extend_offer_banner.dart';
import '../../widgets/today_meal_card.dart';
import '../../widgets/plan_controls_section.dart';
import '../../widgets/feedback_section.dart';
import '../../utils/nav_helpers.dart';
import 'meal_calendar_screen.dart';

class ActiveFoodDashboard extends StatefulWidget {
  const ActiveFoodDashboard({super.key});

  @override
  State<ActiveFoodDashboard> createState() => _ActiveFoodDashboardState();
}

class _ActiveFoodDashboardState extends State<ActiveFoodDashboard> {
  final List<String> statuses = ["Preparing", "Cooking", "Delivered"];
  int currentIndex = 0;
  int daysRemaining = 10;

  @override
  void initState() {
    super.initState();
    _simulateMealProgress();
  }

  void _simulateMealProgress() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentIndex < statuses.length - 1) {
        setState(() => currentIndex++);
      } else {
        timer.cancel();
      }
    });
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showPauseModal() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text("Pause Plan?"),
        content: Text("You have only $daysRemaining days remaining. Do you want to pause?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnack("Plan Paused");
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff6FCF97)),
            child: const Text("Pause Now"),
          )
        ],
      ),
    );
  }

  void _showAddExtraModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Add Extra Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              ListTile(title: const Text("🥗 Salad"), trailing: const Text("₹30")),
              ListTile(title: const Text("🍮 Dessert"), trailing: const Text("₹40")),
              ListTile(title: const Text("🫓 Extra Roti"), trailing: const Text("₹20")),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSnack("Add-on(s) added");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6FCF97),
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Add Selected"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff6FCF97);
    return Scaffold(
      backgroundColor: const Color(0xffF4F9F5),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: Text("Your Active Meal Plan",
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          PlanSummaryCard(daysRemaining: daysRemaining),
          const SizedBox(height: 12),
          const ExtendOfferBanner(),
          const SizedBox(height: 16),
          TodayMealCard(
            statuses: statuses,
            currentIndex: currentIndex,
            onSkip: () => _showSnack("Meal skipped"),
            onAddExtra: _showAddExtraModal,
          ),
          const SizedBox(height: 24),
          PlanControlsSection(
            onPause: _showPauseModal,
            onExtend: () => _showSnack("Plan extended"),
            onViewAll: () => Navigator.push(context, slideFromRight(const MealCalendarScreen())),
          ),
          const SizedBox(height: 24),
          FeedbackSection(
            onRate: () => _showSnack("Thanks for rating!"),
            onHelp: () => _showSnack("Support is on the way!"),
          ),
        ],
      ),
    );
  }
}
