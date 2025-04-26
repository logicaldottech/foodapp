import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step2SelectSlot extends StatefulWidget {
  final String duration;
  final Function(String) onSlotSelected;

  const Step2SelectSlot({
    Key? key,
    required this.duration,
    required this.onSlotSelected,
  }) : super(key: key);

  @override
  State<Step2SelectSlot> createState() => _Step2SelectSlotState();
}

class _Step2SelectSlotState extends State<Step2SelectSlot> {
  String? selectedSlot;

  final List<String> slots = [
    '12:00 PM – 1:00 PM',
    '1:00 PM – 2:00 PM',
    '2:00 PM – 3:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: ListView.separated(
              itemCount: slots.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final slot = slots[index];
                final isSelected = slot == selectedSlot;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSlot = slot;
                    });
                    widget.onSlotSelected(slot); // <--- Important callback here
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
                        const Icon(Icons.access_time_rounded, color: Colors.green),
                        const SizedBox(width: 12),
                        Text(
                          slot,
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
