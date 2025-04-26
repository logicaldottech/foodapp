import 'package:flutter/material.dart';
import 'step8_final_summary.dart';
import 'package:intl/intl.dart';

class Step7DailyMeals extends StatefulWidget {
  final String duration;
  final String deliveryTime;
  final DateTime startDate;
  final DateTime endDate;
  final bool skippingEnabled;
  final List<String> addOns;

  const Step7DailyMeals({
    Key? key,
    required this.duration,
    required this.deliveryTime,
    required this.startDate,
    required this.endDate,
    required this.skippingEnabled,
    required this.addOns,
  }) : super(key: key);

  @override
  State<Step7DailyMeals> createState() => _Step7DailyMealsState();
}

class _Step7DailyMealsState extends State<Step7DailyMeals> {
  final List<String> dishes = ['Rajma', 'Chole', 'Paneer', 'Mix Veg', 'Dal Makhani'];
  final Map<String, String> selectedMeals = {};

  List<DateTime> getDatesBetween(DateTime start, DateTime end) {
    return List.generate(end.difference(start).inDays + 1,
        (i) => DateTime(start.year, start.month, start.day + i));
  }

  void _goToNextStep() {
    if (selectedMeals.length != getDatesBetween(widget.startDate, widget.endDate).length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select meals for each day")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Step8FinalSummary(
          duration: widget.duration,
          deliveryTime: widget.deliveryTime,
          startDate: widget.startDate,
          endDate: widget.endDate,
          skippingEnabled: widget.skippingEnabled,
          addOns: widget.addOns,
          dailyMeals: selectedMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dates = getDatesBetween(widget.startDate, widget.endDate);
    final dateFormat = DateFormat('EEE, dd MMM');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Meals for Each Day"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final formatted = dateFormat.format(date);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatted, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                DropdownButton<String>(
                  value: selectedMeals[formatted],
                  hint: const Text("Choose a dish"),
                  isExpanded: true,
                  items: dishes.map((dish) {
                    return DropdownMenuItem<String>(
                      value: dish,
                      child: Text(dish),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMeals[formatted] = value!;
                    });
                  },
                ),
                const Divider(height: 24),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _goToNextStep,
          child: const Text("Next"),
        ),
      ),
    );
  }
}
