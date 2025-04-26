import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Step3StartDate extends StatefulWidget {
  final String duration;
  final String deliveryTime;
  final Function(DateTime) onStartDateSelected;

  const Step3StartDate({
    Key? key,
    required this.duration,
    required this.deliveryTime,
    required this.onStartDateSelected,
  }) : super(key: key);

  @override
  State<Step3StartDate> createState() => _Step3StartDateState();
}

class _Step3StartDateState extends State<Step3StartDate> {
  DateTime today = DateTime.now();
  DateTime? selectedStartDate;

  @override
  void initState() {
    super.initState();
    selectedStartDate = _calculateInitialDate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStartDateSelected(selectedStartDate!); // Default select initial
    });
  }

  DateTime _calculateInitialDate() {
    if (today.hour >= 18) {
      return today.add(const Duration(days: 1));
    } else {
      return today;
    }
  }

  DateTime _calculateEndDate() {
    final int days = int.tryParse(widget.duration.split(' ').first) ?? 7;
    return selectedStartDate!.add(Duration(days: days - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedStartDate ?? today,
              selectedDayPredicate: (day) => isSameDay(selectedStartDate, day),
              calendarFormat: CalendarFormat.month,
              onDaySelected: (selected, focused) {
                if (!selected.isBefore(today)) {
                  setState(() {
                    selectedStartDate = selected;
                  });
                  widget.onStartDateSelected(selected); // Callback called when user taps
                }
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green.shade400,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
              enabledDayPredicate: (day) => !day.isBefore(today),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.poppins(color: Colors.black54),
                weekendStyle: GoogleFonts.poppins(color: Colors.black54),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black87),
                rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black87),
              ),
            ),
          ),
        ),
        if (selectedStartDate != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "📅 Your subscription will end on: ${DateFormat('d MMMM yyyy').format(_calculateEndDate())}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
