import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/screens/login_screen.dart';
import '../widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Daily Meals at Your Doorstep',
      'subtitle': 'Fresh, home-style veg food — delivered just like mom made it',
      'image': 'assets/images/delivery.png',
    },
    {
      'title': 'Your Daily Needs in One Place',
      'subtitle': 'Food, dairy, laundry, gym, PG help & more — all in one app',
      'image': 'assets/images/services.png',
    },
    {
      'title': 'Let Parents Stay Connected',
      'subtitle': 'They can track or gift your meals — wherever they are',
      'image': 'assets/images/parents.png',
    },
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == _pages.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      body: Stack(
        children: [
          // 🌈 Gradient Top with Curved Background
          Container(
            height: 320,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff7C3AED), Color(0xff00FF87)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 60),

              // 🔁 PageView
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OnboardingContent(
                      title: _pages[i]['title']!,
                      subtitle: _pages[i]['subtitle']!,
                      image: _pages[i]['image']!,
                    ),
                  ),
                ),
              ),

              // 🧊 Bottom Card
              Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // 🔘 Page Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentIndex == index ? 28 : 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? const Color(0xff7C3AED)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🎯 Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ⏩ Skip
                        TextButton(
                          onPressed: _finishOnboarding,
                          child: Text(
                            "Skip",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff7C3AED),
                            ),
                          ),
                        ),

                        // ✅ Next / Get Started
                        ElevatedButton.icon(
                          onPressed: _nextPage,
                          icon: Icon(
                            isLast ? Icons.check_circle_outline : Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: Text(
                            isLast ? "Get Started" : "Next",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: const Color(0xff7C3AED),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
