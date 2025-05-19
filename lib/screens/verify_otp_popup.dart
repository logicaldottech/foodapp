import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void showVerifyOtpPopup(
  BuildContext context,
  Function(String, String) onVerified, {
  bool verifyPhone = true,
  bool verifyEmail = true,
}) {
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
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setModalState) {
          final mq = MediaQuery.of(ctx);
          return AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: mq.viewInsets,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 22,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Wrap(
                runSpacing: 20,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      "🔐 Verify Your OTP",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff1F2937),
                      ),
                    ),
                  ),

                  // 📱 Phone OTP
                  if (verifyPhone) ...[
                    Text("Phone OTP",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey[800])),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (val) => phoneOtp = val,
                      keyboardType: TextInputType.number,
                      textStyle: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      animationType: AnimationType.scale,
                      enableActiveFill: true,
                      pinTheme: _pinTheme(),
                    ),
                  ],

                  // 📧 Email OTP
                  if (verifyEmail) ...[
                    Text("Email OTP",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey[800])),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (val) => emailOtp = val,
                      keyboardType: TextInputType.number,
                      textStyle: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      animationType: AnimationType.scale,
                      enableActiveFill: true,
                      pinTheme: _pinTheme(),
                    ),
                  ],

                  // 🔁 Resend Logic
                  Align(
                    alignment: Alignment.centerRight,
                    child: resendCooldown > 0
                        ? Text("Resend in ${resendCooldown}s",
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey.shade600))
                        : GestureDetector(
                            onTap: () {
                              startResendTimer(() => setModalState(() {}));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("OTP Resent!"),
                                  backgroundColor: Color(0xff7C3AED),
                                ),
                              );
                            },
                            child: Text("Resend OTP",
                                style: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff7C3AED),
                                )),
                          ),
                  ),

                  // ✅ Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        bool validPhone = !verifyPhone || phoneOtp.length == 6;
                        bool validEmail = !verifyEmail || emailOtp.length == 6;

                        if (validPhone && validEmail) {
                          Navigator.pop(context);
                          onVerified(phoneOtp, emailOtp);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter all required OTPs correctly."),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff7C3AED),
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text("Verify",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

PinTheme _pinTheme() {
  return PinTheme(
    shape: PinCodeFieldShape.underline,
    borderRadius: BorderRadius.circular(18),
    fieldHeight: 56,
    fieldWidth: 48,
    inactiveColor: Colors.grey.shade300,
    selectedColor: const Color(0xff7C3AED),
    activeColor: const Color(0xff7C3AED),
    activeFillColor: Colors.white,
    selectedFillColor: Colors.white,
    inactiveFillColor: Colors.grey.shade100,
    borderWidth: 0.8,
  );
}
