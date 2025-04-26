import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/food/active_food_dashboard.dart';
import 'package:foodapp/screens/food/no_plan_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainServicesNewScreen extends StatefulWidget {
  const MainServicesNewScreen({super.key});

  @override
  State<MainServicesNewScreen> createState() => _MainServicesNewScreenState();
}

class _MainServicesNewScreenState extends State<MainServicesNewScreen> {
  String currentLocation = "Detecting location...";
  bool isLoadingLocation = true;
  final ScrollController _scrollController = ScrollController();
  double topBarElevation = 0;

  final List<String> quotes = [
    "“Small steps today lead to big wins tomorrow.”",
    "“Your effort today builds your future.”",
    "“Consistency is the key to mastery.”",
    "“Act now. Progress later. Repeat.”",
    "“Turn ambition into daily action.”",
  ];

  final List<Map<String, dynamic>> services = [
    {
      "title": "Food Subscription",
      "subtitle": "Home-style veg meals",
      "color": Color(0xFFFFF3E0),
      "isLive": true
    },
    {
      "title": "Daily Essentials",
      "subtitle": "Milk, groceries, laundry",
      "color": Color(0xFFE1F5FE),
      "isLive": false
    },
    {
      "title": "Fitness & Wellness",
      "subtitle": "Yoga, gym, meditation",
      "color": Color(0xFFF3E5F5),
      "isLive": false
    },
    {
      "title": "Travel & Stay",
      "subtitle": "Trips, hostels, transport",
      "color": Color(0xFFD1C4E9),
      "isLive": false
    },
    {
      "title": "Finance & Tools",
      "subtitle": "Split bills, expense manager",
      "color": Color(0xFFE0F2F1),
      "isLive": false
    },
  ];

  

  @override
  void initState() {
    super.initState();
    _loadLocation();
    _scrollController.addListener(() {
      setState(() {
        topBarElevation = _scrollController.offset > 10 ? 1 : 0;
      });
    });
  }

  Future<void> _loadLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCity = prefs.getString('selectedCity');

    if (savedCity != null) {
      currentLocation = savedCity;
    } else {
      await _autoDetectCity();
    }
    setState(() => isLoadingLocation = false);
  }
  Future<bool> checkFoodSubscription() async {
  await Future.delayed(const Duration(milliseconds: 500)); // mock API delay
  return false; // 🔁 true = show dashboard, false = no plan
}


  /// ✅ Reverse Geocode from Position (use mock if needed)
  Future<void> _autoDetectCity({Position? mockPosition}) async {
    try {
      Position pos = mockPosition ??
          await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isNotEmpty) {
        String city =
            placemarks.first.locality ?? placemarks.first.subAdministrativeArea ?? "Your City";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('selectedCity', city);

        setState(() => currentLocation = city);
      } else {
        setState(() => currentLocation = "City not found");
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      setState(() => currentLocation = "Error detecting");
    }
  }

  /// ✅ Map Picker for manual selection
  Future<void> _openMapPicker() async {
    LatLng pickedLatLng = const LatLng(19.0760, 72.8777); // default Mumbai
    Completer<GoogleMapController> controller = Completer();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(8),
          content: SizedBox(
            height: 400,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: pickedLatLng, zoom: 14),
              onMapCreated: (ctrl) => controller.complete(ctrl),
              onTap: (LatLng latLng) async {
                Navigator.pop(context);
                Position mockPos = Position(
                  latitude: latLng.latitude,
                  longitude: latLng.longitude,
                  timestamp: DateTime.now(),
                  accuracy: 0,
                  altitude: 0,
                  heading: 0,
                  speed: 0,
                  speedAccuracy: 0,
                  altitudeAccuracy: 0,
                  headingAccuracy: 0,
                );
                await _autoDetectCity(mockPosition: mockPos);
              },
              markers: {
                Marker(
                  markerId: const MarkerId("pick"),
                  position: pickedLatLng,
                  draggable: true,
                )
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff6FCF97), Color(0xff56CCF2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: topBarElevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Your Location",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  GestureDetector(
                    onTap: _openMapPicker,
                    child: Row(
                      children: [
                        const Icon(Icons.place, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text(currentLocation,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        const Icon(Icons.map_outlined,
                            size: 18, color: Colors.white70),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications_none_rounded,
                  color: Colors.white, size: 24),
              const SizedBox(width: 12),
              const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black))
            ],
          ),
          const SizedBox(height: 14),
          Text("Hello, Rahul 👋",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.white.withOpacity(0.9))),
          const SizedBox(height: 2),
          Text("Explore Daily Life Support",
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildQuoteBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffFFF8E1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Color(0xffF2994A), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              quotes[DateTime.now().second % quotes.length],
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> item) {
  return GestureDetector(
    onTap: () {
      if (!item["isLive"]) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text("Coming Soon 🔒"),
                  content: Text("${item['title']} launching soon."),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ));
      }
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item["color"],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/services/food.png",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["title"],
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item["subtitle"],
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.5)),
              ],
            ),
          ),
          item["isLive"]
              ? ElevatedButton.icon(
                  onPressed: () async {
                    final isSubscribed = await checkFoodSubscription();
                    if (isSubscribed) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ActiveFoodDashboard(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NoActivePlanScreen(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text("View"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              : const Icon(Icons.lock_outline, size: 24, color: Colors.grey),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const SizedBox(height: 12),
            _buildQuoteBanner(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: services.length,
                itemBuilder: (context, index) =>
                    _buildServiceCard(services[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
