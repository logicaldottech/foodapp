import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'step9_payment_gateway.dart';

class Step8FinalSummary extends StatefulWidget {
  final String duration;
  final String deliveryTime;
  final DateTime startDate;
  final DateTime endDate;
  final bool skippingEnabled;
  final List<String> addOns;
  final Map<String, String> dailyMeals;

  const Step8FinalSummary({
    Key? key,
    required this.duration,
    required this.deliveryTime,
    required this.startDate,
    required this.endDate,
    required this.skippingEnabled,
    required this.addOns,
    required this.dailyMeals,
  }) : super(key: key);

  @override
  State<Step8FinalSummary> createState() => _Step8FinalSummaryState();
}

class _Step8FinalSummaryState extends State<Step8FinalSummary> {
  final TextEditingController _couponController = TextEditingController();

  void _goToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Step9PaymentGateway(
          duration: widget.duration,
          deliveryTime: widget.deliveryTime,
          startDate: widget.startDate,
          endDate: widget.endDate,
          skippingEnabled: widget.skippingEnabled,
          addOns: widget.addOns,
          dailyMeals: widget.dailyMeals,
          couponCode: _couponController.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Your Subscription"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Duration: ${widget.duration}"),
            Text("Start Date: ${format.format(widget.startDate)}"),
            Text("End Date: ${format.format(widget.endDate)}"),
            Text("Time: ${widget.deliveryTime}"),
            Text("Skipping: ${widget.skippingEnabled ? 'Enabled' : 'Disabled'}"),
            if (widget.addOns.isNotEmpty)
              Text("Add-ons: ${widget.addOns.join(', ')}"),
            const SizedBox(height: 16),
            const Text("Meals Selected:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...widget.dailyMeals.entries.map((entry) =>
              Text("${entry.key}: ${entry.value}")
            ),
            const SizedBox(height: 24),
            const Text("Coupon Code"),
            TextField(
              controller: _couponController,
              decoration: const InputDecoration(
                hintText: "Enter coupon if any",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _goToPayment,
              child: const Text("Proceed to Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
