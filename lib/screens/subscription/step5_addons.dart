import 'package:flutter/material.dart';
import 'step7_daily_meals.dart';

class Step5AddOns extends StatefulWidget {
  final String duration;
  final String deliveryTime;
  final DateTime startDate;
  final DateTime endDate;
  final bool skippingEnabled;

  const Step5AddOns({
    Key? key,
    required this.duration,
    required this.deliveryTime,
    required this.startDate,
    required this.endDate,
    required this.skippingEnabled,
  }) : super(key: key);

  @override
  State<Step5AddOns> createState() => _Step5AddOnsState();
}

class _Step5AddOnsState extends State<Step5AddOns> {
  bool salad = false;
  bool curd = false;
  bool sweet = false;

  void _goToNextStep() {
    List<String> selectedAddOns = [];
    if (salad) selectedAddOns.add('Salad');
    if (curd) selectedAddOns.add('Curd');
    if (sweet) selectedAddOns.add('Sweet');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Step7DailyMeals(
          duration: widget.duration,
          deliveryTime: widget.deliveryTime,
          startDate: widget.startDate,
          endDate: widget.endDate,
          skippingEnabled: widget.skippingEnabled,
          addOns: selectedAddOns,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Would You Like to Add These?"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text("Salad (+₹10/day)"),
              value: salad,
              onChanged: (val) => setState(() => salad = val ?? false),
            ),
            CheckboxListTile(
              title: const Text("Curd (+₹15/day)"),
              value: curd,
              onChanged: (val) => setState(() => curd = val ?? false),
            ),
            CheckboxListTile(
              title: const Text("Sweet (+₹20/day)"),
              value: sweet,
              onChanged: (val) => setState(() => sweet = val ?? false),
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
