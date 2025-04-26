import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otp_popup.dart';
import 'signup_screen.dart';
import 'main_services_screen.dart';
import 'login_with_otp_screen.dart';
import '../widgets/toggle_tabs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inputCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  int selectedTab = 0;

  void login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainServicesNewScreen()),
      );
    }
  }

  Widget buildInputField() {
    return TextFormField(
      controller: _inputCtrl,
      keyboardType:
          selectedTab == 0 ? TextInputType.phone : TextInputType.emailAddress,
      validator: (val) {
        if (val == null || val.isEmpty) return "Required";
        if (selectedTab == 0 && val.length != 10) return "Enter valid mobile number";
        if (selectedTab == 1 && !val.contains('@')) return "Enter valid email";
        return null;
      },
      decoration: InputDecoration(
        labelText: selectedTab == 0 ? "Mobile Number" : "Email Address",
        prefixIcon: Icon(
          selectedTab == 0 ? Icons.phone_android_rounded : Icons.email_rounded,
          color: Colors.teal.shade600,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xff6FCF97), width: 1.6),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passCtrl,
      obscureText: true,
      validator: (val) {
        if (val == null || val.length < 6) return "Minimum 6 characters";
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xff6FCF97)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xff6FCF97), width: 1.6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("FoodApp",
                  style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Welcome Back!",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700])),
              const SizedBox(height: 24),
              // Only 2 tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: List.generate(2, (index) {
                    final selected = selectedTab == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? const Color(0xff6FCF97) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              index == 0 ? "Mobile" : "Email",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: selected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              buildInputField(),
              const SizedBox(height: 16),
              buildPasswordField(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6FCF97),
                      )),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6FCF97),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text("Login",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginWithOtpScreen()));
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff6FCF97)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text("Login with OTP",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, color: const Color(0xff6FCF97))),
              ),
              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "New here? ",
                    style: GoogleFonts.poppins(color: Colors.grey[700]),
                    children: [
                      TextSpan(
                        text: "Create Account",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffF2994A),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignUpScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
