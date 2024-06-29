import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MainDesktop extends StatelessWidget {
  MainDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      height: screenHeight / 1.2,
      constraints: const BoxConstraints(
        minHeight: 350.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // intro message
              const Text(
                "Hi,\nI'm Ahmad Habib\nA Flutter Developer",
                style: TextStyle(
                  fontSize: 30,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.whitePrimary,
                ),
              ),
              const SizedBox(height: 15),
              // contact btn
              SizedBox(
                width: 250.0,
                child: ElevatedButton(
                  onPressed: () {
                    scrollToSection(3);
                  },
                  child: const Text("Get in touch",
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
          // avatar img
          Image.asset(
            "assets/images/Habib.png",
            width: screenWidth / 2,
          ),
        ],
      ),
    );
  }

  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      // open a blog page

      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
