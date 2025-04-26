import 'package:flutter/material.dart';
import 'step2_select_slot.dart'; // Forward navigation

class Step1ChooseDuration extends StatefulWidget {
  const Step1ChooseDuration({Key? key}) : super(key: key);

  @override
  State<Step1ChooseDuration> createState() => _Step1ChooseDurationState();
}

class _Step1ChooseDurationState extends State<Step1ChooseDuration> {
  String? selectedDuration;

  final List<String> durations = ['7 Days', '15 Days', '30 Days'];

  void _goToNextStep() {
    if (selectedDuration != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Step2SelectSlot(duration: selectedDuration!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a duration'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Plan Duration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...durations.map((duration) => RadioListTile<String>(
                  title: Text(duration),
                  value: duration,
                  groupValue: selectedDuration,
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value;
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
