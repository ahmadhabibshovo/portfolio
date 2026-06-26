import 'package:flutter/material.dart';

import '../constants/colors.dart';

BoxDecoration kHederDecoration = BoxDecoration(
  color: CustomColor.bgLight1.withValues(alpha: 0.5),
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    color: Colors.white.withValues(alpha: 0.07),
    width: 1.2,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ],
);
