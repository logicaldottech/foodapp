import 'package:flutter/material.dart';

void showOtpPopup(BuildContext context, Function(String) onSubmit) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      String otp = "";
      int seconds = 30;

      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) => otp = value,
                decoration: const InputDecoration(counterText: "", hintText: "6-digit OTP"),
              ),
              const SizedBox(height: 10),
              Text("Resend OTP in ${seconds}s", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (otp.length == 6) onSubmit(otp);
                  Navigator.pop(context);
                },
                child: const Text("Verify"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
