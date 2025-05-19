import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 🧩 Service Cards
import 'package:foodapp/screens/maincards/foodservices.dart';
import 'package:foodapp/screens/maincards/dairyservices.dart';
import 'package:foodapp/screens/maincards/groceryservices.dart';
import 'package:foodapp/screens/maincards/laundryservices.dart';
import 'package:foodapp/screens/maincards/cleanhomeservices.dart';
import 'package:foodapp/screens/maincards/pgflatservices.dart';
import 'package:foodapp/screens/maincards/tripservices.dart';
import 'package:foodapp/screens/maincards/cabservices.dart';
import 'package:foodapp/screens/maincards/gymservices.dart';
import 'package:foodapp/screens/maincards/saloonservices.dart';

class MainServicesNewScreen extends StatefulWidget {
  const MainServicesNewScreen({super.key});

  @override
  State<MainServicesNewScreen> createState() => _MainServicesNewScreenState();
}

class _MainServicesNewScreenState extends State<MainServicesNewScreen> {
  String selectedLocation = "Select Location";

  final List<String> locationOptions = [
    "Add New Address",
    "Current Location",
  ];

  final List<Widget> _serviceCards = const [
    FoodServiceCard(),
    DairyServiceCard(),
    GroceryServiceCard(),
    LaundryServiceCard(),
    CleanHomeServiceCard(),
    PgFlatServiceCard(),
    TripServiceCard(),
    CabServiceCard(),
    GymServiceCard(),
    SaloonServiceCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔘 Top Row with dropdown and icons
                    Row(
                      children: [
                        const Icon(Icons.place, color: Colors.black54, size: 20),
                        const SizedBox(width: 6),

                        // 📍 Dropdown
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedLocation == "Select Location"
                                ? null
                                : selectedLocation,
                            hint: Text(
                              "Select Location",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            items: locationOptions.map((location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(
                                  location,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedLocation = value;
                                });
                              }
                            },
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: Colors.black54),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            dropdownColor: Colors.white,
                          ),
                        ),

                        const Spacer(),

                        const Icon(Icons.notifications_none_rounded,
                            color: Colors.black54, size: 24),
                        const SizedBox(width: 16),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black12,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // 🧑 Greeting
                    Text(
                      "Hello, Rahul 👋",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Explore Daily Life Support",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🧩 GridView inside scroll
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _serviceCards[index],
                  childCount: _serviceCards.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
