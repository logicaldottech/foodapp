import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:foodapp/screens/subscription/step5_addons.dart'; // 👈 Import Step5 screen

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
  bool skippingEnabled = false;
  List<DateTime> selectedSkipDays = [];

  void _onDateTapped(DateTime date) {
    setState(() {
      if (selectedSkipDays.contains(date)) {
        selectedSkipDays.remove(date);
      } else {
        selectedSkipDays.add(date);
      }
    });
  }

void _onNextPressed() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Step5AddOns(
        duration: widget.duration,
        deliverySlot: widget.deliveryTime,
        startDate: widget.startDate,
        endDate: widget.endDate,
        skippingEnabled: skippingEnabled,
        skipDays: selectedSkipDays,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          "Skip Days Option",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildInfoCard(),
                const SizedBox(height: 32),
                _buildToggleSwitch(),
                const SizedBox(height: 16),
                if (skippingEnabled) _buildCalendarSelector(),
                const SizedBox(height: 24),
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Text(
        "📋 You can skip up to 5 days during your 30-day plan.",
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black54,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.event_note_rounded, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Skipping is optional. You can select days now or later from your account.",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Enable Skipping?",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Tooltip(
                message: "Skipping is optional and manageable later.",
                child: const Icon(Icons.info_outline, size: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: skippingEnabled,
          activeColor: Colors.teal,
          onChanged: (value) {
            setState(() {
              skippingEnabled = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCalendarSelector() {
    return Column(
      children: [
        TableCalendar(
          firstDay: widget.startDate,
          lastDay: widget.endDate,
          focusedDay: widget.startDate,
          selectedDayPredicate: (day) =>
              selectedSkipDays.any((d) => isSameDay(d, day)),
          onDaySelected: (selected, focused) {
            if (!selected.isBefore(widget.startDate) &&
                !selected.isAfter(widget.endDate)) {
              _onDateTapped(selected);
            }
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.teal.shade100,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
          ),
          enabledDayPredicate: (day) =>
              !day.isBefore(widget.startDate) &&
              !day.isAfter(widget.endDate),
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
        const SizedBox(height: 8),
        Text(
          "✅ You selected ${selectedSkipDays.length} skip day(s)",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.teal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: InkWell(
        onTap: _onNextPressed,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "Next",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
