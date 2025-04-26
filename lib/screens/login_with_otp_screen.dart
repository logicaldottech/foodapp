import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/screens/otp_success_screen.dart';
import 'package:foodapp/screens/verify_otp_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_services_screen.dart';
import 'otp_popup.dart';
import 'login_screen.dart';

class LoginWithOtpScreen extends StatefulWidget {
  const LoginWithOtpScreen({super.key});

  @override
  State<LoginWithOtpScreen> createState() => _LoginWithOtpScreenState();
}

class _LoginWithOtpScreenState extends State<LoginWithOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  bool isVerifying = false;

  void sendOtp() {
    if (_formKey.currentState!.validate()) {
      setState(() => isVerifying = true);
      showVerifyOtpPopup(context, (phoneOtp, emailOtp) {
        setState(() => isVerifying = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OtpSuccessScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text("Login with OTP",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.length != 10 ? "Enter valid 10-digit number" : null,
                    inputFormatters: [
    LengthLimitingTextInputFormatter(10),
    FilteringTextInputFormatter.digitsOnly
  ],
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  prefixIcon: const Icon(Icons.phone_android_rounded, color: Color(0xff6FCF97)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xff6FCF97), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isVerifying ? null : sendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6FCF97),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: isVerifying
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Send OTP",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text("Back to Login with Password",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, color: Colors.grey[700])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
