import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_items.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500.0,
      ),
      child: Column(
        children: [
          // platforms
          for (int i = 0; i < platformItems.length; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 15.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: CustomColor.bgLight2.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.06),
                  width: 1.2,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    platformItems[i]["img"],
                    width: 26.0,
                  ),
                ),
                title: Text(
                  platformItems[i]["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 40),

          // skills
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < skillItems.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 14.0,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.bgLight2.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: CustomColor.yellowPrimary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (skillItems[i]["img"] != null)
                        Image.asset(
                          skillItems[i]["img"],
                          width: 20,
                          height: 20,
                        )
                      else
                        const Icon(
                          Icons.code,
                          color: CustomColor.yellowPrimary,
                          size: 16,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        skillItems[i]["title"],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
