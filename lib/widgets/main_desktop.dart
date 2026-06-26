import 'package:flutter/material.dart';
import '../constants/colors.dart';

class MainDesktop extends StatefulWidget {
  const MainDesktop({
    super.key,
    required this.onContactTap,
  });

  final VoidCallback onContactTap;

  @override
  State<MainDesktop> createState() => _MainDesktopState();
}

class _MainDesktopState extends State<MainDesktop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      height: screenHeight / 1.1,
      constraints: const BoxConstraints(
        minHeight: 500.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left column: Intro & Buttons
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // intro message
                const Text(
                  "Hi, my name is",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.yellowSecondary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        CustomColor.cyanGlow,
                        CustomColor.yellowPrimary,
                        CustomColor.purpleGlow,
                      ],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    "Ahmad Habib",
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Mid-Level Flutter Developer | Shipped 17 Production Apps",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.whitePrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "A passionate Mobile App Developer specializing in high-performance Android & iOS solutions. Shipped 8 Android applications to Google Play and 9 iOS applications to the Apple App Store, with expertise in clean architecture, offline synchronization, Mapbox integrations, and payment gateways.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.whiteSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                // contact btn
                SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: widget.onContactTap,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text("Get in touch"),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 40),
          // Right column: Floating Avatar with background glow
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: child,
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow background
                    Container(
                      width: screenWidth / 3,
                      height: screenWidth / 3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            CustomColor.yellowPrimary.withValues(alpha: 0.2),
                            CustomColor.yellowSecondary.withValues(alpha: 0.05),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // Glassmorphic border ring
                    Container(
                      width: screenWidth / 3.4,
                      height: screenWidth / 3.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                          width: 2,
                        ),
                      ),
                    ),
                    // Avatar image
                    ClipOval(
                      child: Image.asset(
                        "assets/images/Habib.png",
                        width: screenWidth / 3.6,
                        height: screenWidth / 3.6,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
