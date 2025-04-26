import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'step4_skipping_rules.dart';

class Step3StartDate extends StatefulWidget {
  final String duration;
  final String deliveryTime;

  const Step3StartDate({
    Key? key,
    required this.duration,
    required this.deliveryTime,
  }) : super(key: key);

  @override
  State<Step3StartDate> createState() => _Step3StartDateState();
}

class _Step3StartDateState extends State<Step3StartDate> {
  DateTime? startDate;
  DateTime? endDate;

  void _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
    );
    if (picked != null) {
      int days = int.parse(widget.duration.split(" ")[0]);
      setState(() {
        startDate = picked;
        endDate = picked.add(Duration(days: days - 1));
      });
    }
  }

  void _goToNextStep() {
    if (startDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Step4SkippingRules(
            duration: widget.duration,
            deliveryTime: widget.deliveryTime,
            startDate: startDate!,
            endDate: endDate!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a start date')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Start Date"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _pickStartDate,
              child: const Text("Choose Start Date"),
            ),
            if (startDate != null && endDate != null) ...[
              const SizedBox(height: 16),
              Text("Start Date: ${dateFormat.format(startDate!)}"),
              Text("End Date: ${dateFormat.format(endDate!)}"),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goToNextStep,
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
