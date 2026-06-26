import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/project_utils.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 60),
      child: Column(
        children: [
          // Work projects title
          const Text(
            "Key Production Projects",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          // Gradient underline
          Container(
            height: 3,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [
                  CustomColor.yellowSecondary,
                  CustomColor.yellowPrimary,
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Work projects cards
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < workProjectUtils.length; i++)
                  ProjectCardWidget(
                    project: workProjectUtils[i],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 80),

          // Hobby projects title
          const Text(
            "Hobby Projects",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          // Gradient underline
          Container(
            height: 3,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [
                  CustomColor.yellowSecondary,
                  CustomColor.yellowPrimary,
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Hobby projects cards
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < hobbyProjectUtils.length; i++)
                  ProjectCardWidget(
                    project: hobbyProjectUtils[i],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

