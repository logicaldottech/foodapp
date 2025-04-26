import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'explore_product_card.dart';

class ExploreRecommendedSection extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Color primary;

  const ExploreRecommendedSection({
    super.key,
    required this.products,
    required this.primary,
  });

  @override
  State<ExploreRecommendedSection> createState() =>
      _ExploreRecommendedSectionState();
}

class _ExploreRecommendedSectionState extends State<ExploreRecommendedSection> {
  final PageController _controller = PageController(viewportFraction: 0.82);
  late Timer _timer;
  int _currentPage = 0;

  List<Map<String, dynamic>> get _recommended =>
      widget.products.where((e) => e['recommended'] == true).toList();

  @override
  void initState() {
    super.initState();
    _autoScroll();
  }

  void _autoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_controller.hasClients && _recommended.isNotEmpty) {
        _currentPage = (_currentPage + 1) % _recommended.length;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_recommended.isEmpty) return const SizedBox();

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Redesigned Header: Gradient label and CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Gradient label for "⭐ Recommended"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff6FCF97), Color(0xff56CCF2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "⭐ Recommended",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "for You",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to the full recommended list screen
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: widget.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 🎠 Horizontal PageView with Snap & Animation
            SizedBox(
              height: 160, // Reduced height for a more compact look
              child: PageView.builder(
                controller: _controller,
                itemCount: _recommended.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: index == _currentPage ? 2 : 8,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.82,
                      child: ExploreProductCard(
                        item: _recommended[index],
                        primary: widget.primary,
                      )
                          .animate(delay: (index * 200).ms)
                          .slideX(begin: 0.3)
                          .fadeIn(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // 🔘 Dot Indicator
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _recommended.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: _currentPage == index ? 16 : 6,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? widget.primary
                          : widget.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
        // 🌫️ Fade Edges for a smooth visual effect
        Positioned.fill(
          child: IgnorePointer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _fadeEdge(context, Alignment.centerLeft),
                _fadeEdge(context, Alignment.centerRight),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _fadeEdge(BuildContext context, Alignment align) {
    return Container(
      width: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: align,
          end: align == Alignment.centerLeft
              ? Alignment.centerRight
              : Alignment.centerLeft,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}
