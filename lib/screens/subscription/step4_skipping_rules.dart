import 'package:flutter/material.dart';
import 'step5_addons.dart';

class Step4SkippingRules extends StatefulWidget {
  final String duration;
  final String deliveryTime;
  final DateTime startDate;
  final DateTime endDate;

  const Step4SkippingRules({
    Key? key,
    required this.duration,
    required this.deliveryTime,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<Step4SkippingRules> createState() => _Step4SkippingRulesState();
}

class _Step4SkippingRulesState extends State<Step4SkippingRules> {
  bool skipEnabled = false;

  void _goToNextStep() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Step5AddOns(
          duration: widget.duration,
          deliveryTime: widget.deliveryTime,
          startDate: widget.startDate,
          endDate: widget.endDate,
          skippingEnabled: skipEnabled,
        ),
      ),
    );
  }

  String getSkipNote() {
    if (widget.duration.contains('30')) return 'You can skip up to 5 days in 30-day plan';
    if (widget.duration.contains('15')) return 'You can skip up to 2 days in 15-day plan';
    if (widget.duration.contains('7')) return 'You can skip 1 day in 7-day plan';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skip Days Option"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getSkipNote(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text("Enable Skipping"),
              value: skipEnabled,
              onChanged: (value) {
                setState(() {
                  skipEnabled = value;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goToNextStep,
                child: const Text("Next"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
