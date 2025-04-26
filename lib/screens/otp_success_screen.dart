import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_password_screen.dart';
import 'main_services_screen.dart';

class OtpSuccessScreen extends StatefulWidget {
  final bool fromSignUp;
  const OtpSuccessScreen({super.key, this.fromSignUp = false});

  @override
  State<OtpSuccessScreen> createState() => _OtpSuccessScreenState();
}

class _OtpSuccessScreenState extends State<OtpSuccessScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              widget.fromSignUp ? const CreatePasswordScreen() : const MainServicesNewScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0FFF6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_rounded, color: Color(0xff6FCF97), size: 80),
            const SizedBox(height: 20),
            Text("OTP Verified!",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Redirecting...",
                style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
