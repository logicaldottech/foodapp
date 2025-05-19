import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import 'otp_success_screen.dart';
import 'verify_otp_popup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;
  String _passwordStrength = '';
  Color _strengthColor = Colors.transparent;

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  int userType = -1;
  bool isVerifying = false;

  void _checkPasswordStrength(String password) {
    String strength = '';
    Color color = Colors.red;

    if (password.isEmpty) {
      strength = '';
      color = Colors.transparent;
    } else if (password.length < 6) {
      strength = 'Weak';
      color = Colors.red;
    } else if (RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(password)) {
      strength = 'Medium';
      color = Colors.orange;
    }
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$')
        .hasMatch(password)) {
      strength = 'Strong';
      color = Colors.green;
    }

    setState(() {
      _passwordStrength = strength;
      _strengthColor = color;
    });
  }

  Future<void> _selectProfileImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) setState(() => _profileImage = File(picked.path));
  }

  void showOtp() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept the Terms & Conditions")),
      );
      return;
    }

    setState(() => isVerifying = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      showVerifyOtpPopup(context, (phoneOtp, emailOtp) {
        setState(() => isVerifying = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OtpSuccessScreen()),
        );
      });
    });
  }

  InputDecoration _inputDecoration(String label, IconData icon, {String? prefixText}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xff7C3AED)),
      prefixText: prefixText,
      prefixStyle: GoogleFonts.poppins(fontSize: 15),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xff7C3AED), width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggleVisibility,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      style: GoogleFonts.poppins(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xff7C3AED)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff7C3AED), width: 1.5),
          borderRadius: BorderRadius.circular(14),
        ),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildUserTypeCard(String title, String desc, int index) {
    final selected = userType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => userType = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: selected ? const Color(0xff7C3AED) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? const Color(0xff7C3AED) : Colors.grey.shade300,
              width: 1.3,
            ),
            boxShadow: selected
                ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: Column(
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.black)),
              const SizedBox(height: 4),
              Text(desc,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: selected ? Colors.white70 : Colors.grey[700])),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      body: Stack(
        children: [
          // 🌈 Gradient Header
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
                  const SizedBox(height: 30),
                  Text("Create Your Account",
                      style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 6),
                  Text("Let’s get started",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white70)),
                  const SizedBox(height: 30),

                  // 🧊 Glass Form Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.96),
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
                          GestureDetector(
                            onTap: _selectProfileImage,
                            child: CircleAvatar(
                              radius: 46,
                              backgroundColor:
                                  const Color(0xff7C3AED).withOpacity(0.12),
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ? const Icon(Icons.camera_alt_rounded,
                                      size: 28, color: Color(0xff7C3AED))
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _nameCtrl,
                            decoration:
                                _inputDecoration("Full Name", Icons.person),
                            validator: (val) => val == null || val.isEmpty
                                ? "Name required"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: _inputDecoration(
                              "Phone Number",
                              Icons.phone_android,
                              prefixText: "+91 ",
                            ),
                            validator: (val) => val == null || val.length != 10
                                ? "Enter valid 10-digit number"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                _inputDecoration("Email", Icons.email_outlined),
                            validator: (val) => val == null || !val.contains("@")
                                ? "Enter a valid email"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          _buildPasswordField(
                            controller: _passCtrl,
                            label: "Create Password",
                            obscure: _obscurePass,
                            toggleVisibility: () =>
                                setState(() => _obscurePass = !_obscurePass),
                            validator: (val) {
                              if (val == null || val.length < 6) {
                                return "Minimum 6 characters required";
                              }
                              return null;
                            },
                            onChanged: _checkPasswordStrength,
                          ),
                          const SizedBox(height: 6),
                          if (_passCtrl.text.isNotEmpty)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Strength: $_passwordStrength",
                                style: TextStyle(
                                  color: _strengthColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          _buildPasswordField(
                            controller: _confirmCtrl,
                            label: "Confirm Password",
                            obscure: _obscureConfirm,
                            toggleVisibility: () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                            validator: (val) {
                              if (val == null || val != _passCtrl.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            onChanged: (_) => _formKey.currentState!.validate(),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Who are you using this app for?",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _buildUserTypeCard("Self", "Ordering for myself", 0),
                              _buildUserTypeCard("Parent", "Managing someone else", 1),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _agreeTerms,
                                onChanged: (val) =>
                                    setState(() => _agreeTerms = val ?? false),
                                activeColor: const Color(0xff7C3AED),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "I agree to the Terms and Conditions and Privacy Policy.",
                                  style: GoogleFonts.poppins(fontSize: 13.5),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 6),
                          ElevatedButton(
                            onPressed: isVerifying ? null : showOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff7C3AED),
                              foregroundColor: Colors.white, 
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: isVerifying
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Color.fromARGB(255, 255, 255, 255)),
                                  )
                                : Text("Verify Phone and Email",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            ),
                            child: Text(
                              "Already have an account? Login",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff7C3AED),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.8),
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
}
