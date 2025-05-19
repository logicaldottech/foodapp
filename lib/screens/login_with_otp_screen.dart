import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'verify_otp_popup.dart';
import 'otp_success_screen.dart';

class LoginWithOtpScreen extends StatefulWidget {
  const LoginWithOtpScreen({super.key});

  @override
  State<LoginWithOtpScreen> createState() => _LoginWithOtpScreenState();
}

class _LoginWithOtpScreenState extends State<LoginWithOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginCtrl = TextEditingController(); // 📧 or 📞
  bool isVerifying = false;

  void sendOtp() {
    if (_formKey.currentState!.validate()) {
      setState(() => isVerifying = true);

      Future.delayed(const Duration(milliseconds: 600), () {
        String input = _loginCtrl.text.trim();
        bool isEmail = input.contains('@');

        showVerifyOtpPopup(
          context,
          (phoneOtp, emailOtp) {
            setState(() => isVerifying = false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OtpSuccessScreen()),
            );
          },
          verifyPhone: !isEmail,
          verifyEmail: isEmail,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffF3F4F6),
      body: Stack(
        children: [
          // 🌈 Gradient Background
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff7F00FF), Color(0xff00FF87)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text("OTP Login 🔐",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 6),
                  Text("Get OTP on your phone or email",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white70)),

                  const SizedBox(height: 30),

                  // 🧊 Glass Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // 📥 Input Field (Phone or Email)
                          TextFormField(
                            controller: _loginCtrl,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9a-zA-Z@._]")),
                            ],
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Enter mobile or email";
                              }

                              String value = val.trim();

                              if (value.contains('@')) {
                                // 📧 Email validation
                                if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                    .hasMatch(value)) {
                                  return "Enter valid email address";
                                }
                              } else if (RegExp(r"^\d+$").hasMatch(value)) {
                                // 📱 Phone validation
                                if (value.length != 10) {
                                  return "Enter valid 10-digit mobile number";
                                }
                              } else {
                                // ❌ Mixed/Invalid Input
                                return "Enter valid email address";
                              }

                              return null;
                            },
                            style: GoogleFonts.poppins(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Mobile or Email",
                              prefixIcon: const Icon(Icons.account_circle_outlined,
                                  color: Color(0xff7C3AED)),
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Color(0xff7C3AED), width: 1.5),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ✅ Send OTP button
                          ElevatedButton(
                            onPressed: isVerifying ? null : sendOtp,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: const Color(0xff7C3AED),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: isVerifying
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.5, color: Colors.white))
                                : Text("Send OTP",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white)),
                          ),

                          const SizedBox(height: 20),

                          // 🔙 Back to login
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()),
                              );
                            },
                            child: Text("← Back to Login with Password",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff7C3AED))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
