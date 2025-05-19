import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  final String currentPage;

  const AppDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧑 Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff7F00FF), Color(0xff00FF87)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  "Hello, Rahul",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // 📄 Menu Items
          _buildMenuItem(
            context,
            icon: Icons.home,
            label: "Home",
            routeName: "home",
          ),
          _buildMenuItem(
            context,
            icon: Icons.fastfood_rounded,
            label: "Explore Food",
            routeName: "explore",
          ),
          _buildMenuItem(
            context,
            icon: Icons.shopping_cart_outlined,
            label: "Orders",
            routeName: "orders",
          ),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            label: "Profile",
            routeName: "profile",
          ),
          const Spacer(),
          Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              "Logout",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              // TODO: Handle logout
            },
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String label,
      required String routeName}) {
    final bool isSelected = currentPage == routeName;
    return ListTile(
      leading: Icon(icon,
          color: isSelected ? const Color(0xff7C3AED) : Colors.grey.shade700),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          color: isSelected ? const Color(0xff7C3AED) : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // close drawer
        if (!isSelected) {
          // Navigate if not already there
          // You can replace with named routes or push
        }
      },
    );
  }
}
