import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversalButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const UniversalButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<UniversalButton> createState() => _UniversalButtonState();
}

class _UniversalButtonState extends State<UniversalButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final gradientColors = widget.isEnabled
        ? [const Color(0xFFA8E063), const Color(0xFF56AB2F)]
        : [const Color(0xFFA8E063).withOpacity(0.5), const Color(0xFF56AB2F).withOpacity(0.5)];

    return MouseRegion(
      onEnter: (_) {
        if (widget.isEnabled) setState(() => _isHovering = true);
      },
      onExit: (_) {
        if (widget.isEnabled) setState(() => _isHovering = false);
      },
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: widget.isEnabled ? Colors.black26 : Colors.black12,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (widget.isEnabled) ...[
                  const SizedBox(width: 8),
                  AnimatedSlide(
                    offset: _isHovering ? const Offset(0.2, 0) : Offset.zero,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
