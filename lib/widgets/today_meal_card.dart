import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayMealCard extends StatefulWidget {
  final VoidCallback onSkip;
  final VoidCallback onAddExtra;
  final List<String> statuses;
  final int currentIndex;

  const TodayMealCard({
    super.key,
    required this.onSkip,
    required this.onAddExtra,
    required this.statuses,
    required this.currentIndex,
  });

  @override
  State<TodayMealCard> createState() => _TodayMealCardState();
}

class _TodayMealCardState extends State<TodayMealCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.statuses[widget.currentIndex];
    final isDelivered = status == "Delivered";
    const primary = Color(0xff6FCF97);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _text("Today’s Meal", 15, FontWeight.w600),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  "assets/services/food.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text("Aloo Paratha with Curd", 15, FontWeight.w600),
                    const SizedBox(height: 4),
                    _text("Add-on: Salad", 13, FontWeight.w400),
                    const SizedBox(height: 8),
                    _statusPill(status),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          _timeline(widget.statuses, widget.currentIndex),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isDelivered ? null : widget.onSkip,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Skip Today"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onAddExtra,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text("Add Extra"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _statusPill(String status) {
    Color bg = Colors.grey.shade200;
    Color textColor = Colors.black;

    if (status == "Preparing") {
      bg = const Color(0xffFFF3E0);
      textColor = const Color(0xffFB8C00);
    } else if (status == "Delivered") {
      bg = const Color(0xffE8F5E9);
      textColor = const Color(0xff388E3C);
    } else if (status == "Scheduled") {
      bg = const Color(0xffE3F2FD);
      textColor = const Color(0xff1976D2);
    }

    final pill = Container(
      key: ValueKey(status),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
            fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) =>
          ScaleTransition(scale: anim, child: FadeTransition(opacity: anim, child: child)),
      child: status == "Preparing"
          ? ScaleTransition(scale: _pulseController, child: pill)
          : pill,
    );
  }

  Widget _timeline(List<String> statuses, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(statuses.length * 2 - 1, (i) {
        if (i.isEven) {
          final idx = i ~/ 2;
          final isDone = idx <= index;
          return Column(
            children: [
              CircleAvatar(
                radius: 6,
                backgroundColor:
                    isDone ? const Color(0xff6FCF97) : Colors.grey.shade300,
              ),
              const SizedBox(height: 4),
              _text(statuses[idx], 11, FontWeight.w400),
            ],
          );
        } else {
          return Container(
            width: 30,
            height: 2,
            color: i < index * 2
                ? const Color(0xff6FCF97)
                : Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 4),
          );
        }
      }),
    );
  }

  Text _text(String txt, double size, FontWeight weight) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: size, fontWeight: weight),
    );
  }
}
