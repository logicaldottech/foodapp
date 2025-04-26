import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/otp_success_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
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

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  int userType = -1;
  bool isVerifying = false;

  bool get isFormValid {
    return _nameCtrl.text.trim().isNotEmpty &&
        _phoneCtrl.text.trim().length == 10 &&
        _emailCtrl.text.contains('@') &&
        userType != -1;
  }

  Future<void> _selectProfileImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text("Take a photo"),
              onTap: () async {
                Navigator.pop(context);
                final picked = await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);
                if (picked != null) setState(() => _profileImage = File(picked.path));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text("Choose from gallery"),
              onTap: () async {
                Navigator.pop(context);
                final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
                if (picked != null) setState(() => _profileImage = File(picked.path));
              },
            ),
          ],
        );
      },
    );
  }

  void showOtp() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isVerifying = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      showVerifyOtpPopup(context, (phoneOtp, emailOtp) {
  setState(() => isVerifying = false); // ✅ loader off

  // ✅ Navigate to OTP success screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const OtpSuccessScreen()),
  );
});

    });
  }

  InputDecoration fieldStyle(String label, IconData icon, {String? prefixText}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.teal.shade600),
      prefixText: prefixText,
      prefixStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xff6FCF97), width: 1.6),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? formatters,
    String? prefixText,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      inputFormatters: formatters,
      maxLength: maxLength,
      style: GoogleFonts.poppins(fontSize: 15),
      decoration: fieldStyle(label, icon, prefixText: prefixText),
      validator: validator,
    );
  }

  Widget userTypeCard(String title, String desc, int index) {
    final selected = userType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => userType = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: selected ? const Color(0xff6FCF97) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? const Color(0xff6FCF97) : Colors.grey.shade300,
              width: 1.3,
            ),
            boxShadow: selected
                ? [BoxShadow(color: Colors.green.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: Column(
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: selected ? Colors.white : Colors.black)),
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

  Widget buildAvatarUploader() {
    return GestureDetector(
      onTap: _selectProfileImage,
      child: CircleAvatar(
        radius: 48,
        backgroundColor: const Color(0xff6FCF97).withOpacity(0.15),
        backgroundImage: _profileImage != null
            ? FileImage(_profileImage!)
            : const AssetImage("assets/images/signup_avatar.png") as ImageProvider,
        child: _profileImage == null
            ? const Icon(Icons.camera_alt_rounded, size: 30, color: Color(0xff6FCF97))
            : null,
      ),
    );
  }

  Widget buildBottomSection() {
    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isFormValid ? 1 : 0.7,
              child: ElevatedButton(
                onPressed: isFormValid && !isVerifying ? showOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid ? const Color(0xff6FCF97) : Colors.grey.shade400,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: isVerifying
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text("Verify Phone and Email",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: Text(
                "Already have an account? Login",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.3,
        backgroundColor: Colors.white,
        title: Text("Create Your Account",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 150),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  buildAvatarUploader(),
                  const SizedBox(height: 30),
                  buildTextField(
                    controller: _nameCtrl,
                    label: "Full Name",
                    icon: Icons.person_rounded,
                    validator: (val) => (val == null || val.isEmpty) ? "Name required" : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: _phoneCtrl,
                    label: "Mobile Number",
                    icon: Icons.smartphone_rounded,
                    type: TextInputType.phone,
                    prefixText: "+91 ",
                    maxLength: 10,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => (val == null || val.length != 10) ? "10-digit number required" : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: _emailCtrl,
                    label: "Email Address",
                    icon: Icons.mail_rounded,
                    type: TextInputType.emailAddress,
                    validator: (val) => (val == null || !val.contains("@")) ? "Valid email required" : null,
                  ),
                  const SizedBox(height: 28),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Who are you using this app for?",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      userTypeCard("Self", "I want to order for myself", 0),
                      userTypeCard("Parent", "I'm managing for someone else", 1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomSection(),
    );
  }
}
