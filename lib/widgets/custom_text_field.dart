import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.maxLines = 1,
    this.hintText,
  });
  final TextEditingController? controller;
  final int maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: CustomColor.whitePrimary,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: CustomColor.bgLight2.withValues(alpha: 0.4),
        focusedBorder: getInputBorder(
            CustomColor.yellowSecondary.withValues(alpha: 0.7), 1.5),
        enabledBorder:
            getInputBorder(Colors.white.withValues(alpha: 0.08), 1.0),
        border: getInputBorder(Colors.white.withValues(alpha: 0.08), 1.0),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColor.hintDark,
        ),
      ),
    );
  }

  OutlineInputBorder getInputBorder(Color borderColor, double borderWidth) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }
}
