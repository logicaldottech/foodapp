import 'package:flutter/material.dart';
import 'package:foodapp/screens/subscription/step1_choose_duration.dart';
import 'package:foodapp/screens/subscription/step2_select_slot.dart';
import 'package:foodapp/screens/subscription/step3_start_date.dart';
import 'package:foodapp/screens/subscription/step4_skipping_rules.dart';

class Step1toStep3 extends StatefulWidget {
  const Step1toStep3({Key? key}) : super(key: key);

  @override
  State<Step1toStep3> createState() => _Step1toStep3State();
}

class _Step1toStep3State extends State<Step1toStep3> {
  int currentStep = 0;

  String? selectedDuration;
  String? selectedSlot;
  DateTime? selectedStartDate;

  void _nextStep() {
    if (currentStep == 0 && selectedDuration == null) {
      _showSnackbar('Please select a plan duration');
      return;
    }
    if (currentStep == 1 && selectedSlot == null) {
      _showSnackbar('Please select a delivery slot');
      return;
    }
    if (currentStep == 2 && selectedStartDate == null) {
      _showSnackbar('Please select a start date');
      return;
    }

    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Step4SkippingRules(
            duration: selectedDuration!,
            deliveryTime: selectedSlot!,
            startDate: selectedStartDate!,
            endDate: _calculateEndDate(),
          ),
        ),
      );
    }
  }

  DateTime _calculateEndDate() {
    final int days = int.tryParse(selectedDuration?.split(' ').first ?? '7') ?? 7;
    return selectedStartDate!.add(Duration(days: days - 1));
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _getCurrentStepWidget() {
    switch (currentStep) {
      case 0:
        return Step1ChooseDuration(
          onDurationSelected: (duration) {
            setState(() {
              selectedDuration = duration;
            });
          },
        );
      case 1:
        return Step2SelectSlot(
          duration: selectedDuration!,
          onSlotSelected: (slot) {
            setState(() {
              selectedSlot = slot;
            });
          },
        );
      case 2:
        return Step3StartDate(
          duration: selectedDuration!,
          deliveryTime: selectedSlot!,
          onStartDateSelected: (date) {
            setState(() {
              selectedStartDate = date;
            });
          },
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildStepProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepCircle(0, "Plan"),
          _buildDivider(0),
          _buildStepCircle(1, "Slot"),
          _buildDivider(1),
          _buildStepCircle(2, "Date"),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int stepNumber, String label) {
    bool isActive = currentStep == stepNumber;
    bool isCompleted = currentStep > stepNumber;

    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive || isCompleted ? Colors.teal : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    "${stepNumber + 1}",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: isActive || isCompleted ? Colors.teal : Colors.grey,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(int afterStep) {
    bool isActive = currentStep > afterStep;

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 2,
        color: isActive ? Colors.teal : Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  String _getTitle() {
    switch (currentStep) {
      case 0:
        return "Select Plan Duration";
      case 1:
        return "Choose Delivery Time";
      case 2:
        return "Select Your Start Date";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          _getTitle(),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStepProgress(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _getCurrentStepWidget(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.teal,
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
