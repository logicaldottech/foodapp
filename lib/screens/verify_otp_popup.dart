import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void showVerifyOtpPopup(BuildContext context, Function(String, String) onVerified) {
  String phoneOtp = '';
  String emailOtp = '';
  int resendCooldown = 30;
  Timer? _resendTimer;

  void startResendTimer(VoidCallback update) {
    resendCooldown = 30;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendCooldown--;
      update();
      if (resendCooldown == 0) {
        _resendTimer?.cancel();
      }
    });
  }

  showModalBottomSheet(
    context: context,
    isDismissible: false,     // ⛔ can't close by tapping outside
    enableDrag: false,        // ⛔ can't swipe down to close
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setModalState) {
          final mq = MediaQuery.of(ctx);
          return Padding(
            padding: mq.viewInsets,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Wrap(
                runSpacing: 18,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      "Verify OTP",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("📱 Enter 6-digit code sent to your phone",
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (val) => phoneOtp = val,
                    keyboardType: TextInputType.number,
                    textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
                    animationType: AnimationType.fade,
                    enableActiveFill: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(14),
                      fieldHeight: 54,
                      fieldWidth: 48,
                      activeColor: const Color(0xff6FCF97),
                      selectedColor: const Color(0xff6FCF97),
                      inactiveColor: Colors.grey.shade300,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.grey.shade100,
                      borderWidth: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("📧 Enter 6-digit code sent to your email",
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (val) => emailOtp = val,
                    keyboardType: TextInputType.number,
                    textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
                    animationType: AnimationType.fade,
                    enableActiveFill: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(14),
                      fieldHeight: 54,
                      fieldWidth: 48,
                      activeColor: const Color(0xff6FCF97),
                      selectedColor: const Color(0xff6FCF97),
                      inactiveColor: Colors.grey.shade300,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.grey.shade100,
                      borderWidth: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: resendCooldown > 0
                        ? Text(
                            "Resend in ${resendCooldown}s",
                            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
                          )
                        : GestureDetector(
                            onTap: () {
                              startResendTimer(() => setModalState(() {}));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("OTP Resent!"),
                                backgroundColor: Color(0xff6FCF97),
                              ));
                            },
                            child: Text(
                              "Resend OTP",
                              style: GoogleFonts.poppins(
                                color: const Color(0xff6FCF97),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (phoneOtp.length == 6 && emailOtp.length == 6) {
                          Navigator.pop(context);
                          onVerified(phoneOtp, emailOtp);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Both OTPs must be 6 digits"),
                            backgroundColor: Colors.redAccent,
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6FCF97),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text("Verify", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
