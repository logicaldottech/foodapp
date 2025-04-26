import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step1ChooseDuration extends StatefulWidget {
  final Function(String) onDurationSelected;

  const Step1ChooseDuration({Key? key, required this.onDurationSelected}) : super(key: key);

  @override
  State<Step1ChooseDuration> createState() => _Step1ChooseDurationState();
}

class _Step1ChooseDurationState extends State<Step1ChooseDuration> {
  String? selectedDuration;

  final List<String> durations = ['7 Days', '15 Days', '30 Days'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: ListView.separated(
              itemCount: durations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final duration = durations[index];
                final isSelected = duration == selectedDuration;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDuration = duration;
                    });
                    widget.onDurationSelected(duration); // <--- THIS is important now
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.greenAccent.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, color: Colors.green),
                        const SizedBox(width: 12),
                        Text(
                          duration,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
