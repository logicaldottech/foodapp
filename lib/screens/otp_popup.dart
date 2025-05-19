import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showOtpPopup(BuildContext context, Function(String) onSubmit) {
  String otp = "";
  int seconds = 30;
  late Timer timer;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // Start countdown
          if (seconds == 30) {
            timer = Timer.periodic(const Duration(seconds: 1), (t) {
              if (seconds == 0) {
                t.cancel();
              } else {
                setState(() => seconds--);
              }
            });
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white.withOpacity(0.95),
            elevation: 12,
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("🔐 Enter OTP",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 12),
                Text("A 6-digit code was sent to your number",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 13.5, color: Colors.grey[600])),
                const SizedBox(height: 20),

                // ✅ OTP input
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: (val) => otp = val,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 18, letterSpacing: 3),
                  decoration: InputDecoration(
                    hintText: "------",
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff7C3AED), width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ⏳ Resend
                Text(
                  seconds > 0
                      ? "Resend OTP in ${seconds}s"
                      : "Didn't receive? Try again",
                  style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.grey[700]),
                ),

                const SizedBox(height: 20),

                // ✅ Verify Button
                ElevatedButton(
                  onPressed: () {
                    if (otp.length == 6) {
                      timer.cancel();
                      Navigator.pop(context);
                      onSubmit(otp);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: const Color(0xff7C3AED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text("Verify",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
