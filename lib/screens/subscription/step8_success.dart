import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Step10Success extends StatelessWidget {
  final String planName;
  final DateTime nextDelivery;

  const Step10Success({
    Key? key,
    required this.planName,
    required this.nextDelivery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy').format(nextDelivery);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("You're Subscribed!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.verified, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            Text(
              "You've successfully subscribed to the $planName",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              "Next Delivery Date: $formattedDate",
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("View My Subscription"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
