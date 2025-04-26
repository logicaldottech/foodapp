import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealCalendarScreen extends StatefulWidget {
  const MealCalendarScreen({super.key});

  @override
  State<MealCalendarScreen> createState() => _MealCalendarScreenState();
}

class _MealCalendarScreenState extends State<MealCalendarScreen> {
  int selectedDay = 0;

  final List<String> week = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
  ];

  final List<String> meals = [
    "Aloo Paratha + Curd",
    "Paneer Sabzi + Roti",
    "Chole Bhature",
    "Daal Tadka + Rice",
    "Veg Biryani + Raita",
    "Rajma Chawal",
    "Masala Dosa",
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff6FCF97);
    return Scaffold(
      backgroundColor: const Color(0xffF4F9F5),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: Text(
          "Your Weekly Meals",
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDaySelector(primary),
          const SizedBox(height: 20),
          _buildMealCard(primary),
        ],
      ),
    );
  }

  Widget _buildDaySelector(Color primary) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: week.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = selectedDay == index;
          return GestureDetector(
            onTap: () => setState(() => selectedDay = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(week[index],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black)),
                  const SizedBox(height: 4),
                  Text("Day ${index + 1}",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isSelected ? Colors.white70 : Colors.black54))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealCard(Color primary) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🍽️ ${meals[selectedDay]}",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Text("Add-on: Salad", style: GoogleFonts.poppins(fontSize: 13)),
            const Spacer(),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel_outlined, size: 16),
                  label: const Text("Skip"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add Extra"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
