import 'package:flutter/material.dart';
import '../constants/colors.dart';

class MainMobile extends StatefulWidget {
  const MainMobile({
    super.key,
    required this.onContactTap,
  });

  final VoidCallback onContactTap;

  @override
  State<MainMobile> createState() => _MainMobileState();
}

class _MainMobileState extends State<MainMobile>
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

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
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
    final screenWidth = screenSize.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Floating Avatar with background glow
          AnimatedBuilder(
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
                  width: screenWidth * 0.7,
                  height: screenWidth * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        CustomColor.yellowPrimary.withValues(alpha: 0.15),
                        CustomColor.yellowSecondary.withValues(alpha: 0.03),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Glassmorphic border ring
                Container(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                      width: 1.5,
                    ),
                  ),
                ),
                // Avatar image
                ClipOval(
                  child: Image.asset(
                    "assets/images/Habib.png",
                    width: screenWidth * 0.55,
                    height: screenWidth * 0.55,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Intro details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi, my name is",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.yellowSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 5),
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
                    fontSize: 36,
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.whitePrimary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "A passionate Mobile App Developer specializing in high-performance Android & iOS solutions. Shipped 8 Android applications to Google Play and 9 iOS applications to the Apple App Store.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.whiteSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 25),
              // contact btn
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: widget.onContactTap,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: const Text("Get in touch"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
