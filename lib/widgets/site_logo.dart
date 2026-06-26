import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SiteLogo extends StatelessWidget {
  const SiteLogo({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        "Ahmad Habib",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: CustomColor.yellowSecondary,
        ),
      ),
    );
  }
}
