import 'package:flutter/material.dart';
import 'step3_start_date.dart';

class Step2SelectSlot extends StatefulWidget {
  final String duration;

  const Step2SelectSlot({Key? key, required this.duration}) : super(key: key);

  @override
  State<Step2SelectSlot> createState() => _Step2SelectSlotState();
}

class _Step2SelectSlotState extends State<Step2SelectSlot> {
  String? selectedSlot;

  final List<String> timeSlots = [
    '12:00 PM – 1:00 PM',
    '1:00 PM – 2:00 PM',
    '2:00 PM – 3:00 PM',
  ];

  void _goToNextStep() {
    if (selectedSlot != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Step3StartDate(
            duration: widget.duration,
            deliveryTime: selectedSlot!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a delivery time')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Delivery Time"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...timeSlots.map((slot) => RadioListTile<String>(
                  title: Text(slot),
                  value: slot,
                  groupValue: selectedSlot,
                  onChanged: (value) {
                    setState(() {
                      selectedSlot = value;
                    });
                  },
                )),
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
