import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_screen.dart';
import 'main_services_screen.dart';
import 'login_with_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginCtrl = TextEditingController(); // 🧠 Merged controller
  final _passCtrl = TextEditingController();

  bool _obscure = true;

  void login() {
    if (_formKey.currentState!.validate()) {
      // 👇 You can handle login type here if needed
      String input = _loginCtrl.text.trim();
      bool isEmail = input.contains("@");

      print("Detected login type: ${isEmail ? "Email" : "Phone"}");
      print("Login as: $input");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainServicesNewScreen()),
      );
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
                  Text("Welcome Back 👋",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 6),
                  Text("Please login to continue",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white70)),

                  const SizedBox(height: 30),

                  // 🧊 Login Form Card
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
                          TextFormField(
                            controller: _loginCtrl,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Required";
                              }

                              String value = val.trim();

                              if (value.contains('@')) {
                                // Email validation
                                if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                    .hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                              } else {
                                // Phone validation
                                if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                                  return "Enter 10-digit mobile number";
                                }
                              }
                              return null;
                            },
                            decoration: _inputDecoration(
                                "Email or Mobile", Icons.alternate_email),
                          ),
                          const SizedBox(height: 16),

                          // 🔐 Password Field
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            validator: (val) =>
                                val == null || val.length < 6
                                    ? "Minimum 6 characters"
                                    : null,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: Color(0xff7C3AED)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
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
                          const SizedBox(height: 12),

                          // 🔗 Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text("Forgot Password?",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff7C3AED),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // 🔘 Login Button
                          ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: const Color(0xff7C3AED),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text("Login",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white)),
                          ),
                          const SizedBox(height: 12),

                          // 🔁 OTP Login
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginWithOtpScreen()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side:
                                  const BorderSide(color: Color(0xff7C3AED)),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text("Login with OTP",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff7C3AED))),
                          ),
                          const SizedBox(height: 24),

                          // 📎 Create account
                          RichText(
                            text: TextSpan(
                              text: "New here? ",
                              style: GoogleFonts.poppins(
                                  color: Colors.grey.shade700),
                              children: [
                                TextSpan(
                                  text: "Create Account",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffF97316),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpScreen()),
                                      );
                                    },
                                ),
                              ],
                            ),
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

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xff7C3AED)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xff7C3AED), width: 1.5),
      ),
    );
  }
}
