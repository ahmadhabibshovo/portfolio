import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/skill_entity.dart';

class SkillsSection extends StatefulWidget {
  final List<SkillEntity> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    // Extract unique categories using spread operator
    final categories = ['All', ...widget.skills.map((s) => s.category).toSet()];

    final displaySkills = _selectedCategory == 'All'
        ? widget.skills
        : widget.skills
              .where(
                (s) =>
                    s.category.toLowerCase() == _selectedCategory.toLowerCase(),
              )
              .toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategory = cat);
                      }
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF0F172A)
                          : AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.cardBorder,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 32),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 600
                  ? 2
                  : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displaySkills.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (context, index) {
                  return _buildSkillCard(displaySkills[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECHNICAL EXPERTISE',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Languages, Tools & Technologies',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillCard(SkillEntity skill) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _getSkillIcon(skill.name),
                    const SizedBox(width: 12),
                    Text(
                      skill.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${skill.proficiency}%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: skill.proficiency / 100.0,
                minHeight: 6,
                backgroundColor: AppColors.cardBorder,
                valueColor: AlwaysStoppedAnimation<Color>(
                  skill.proficiency >= 85
                      ? AppColors.primary
                      : skill.proficiency >= 75
                      ? AppColors.secondary
                      : AppColors.accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSkillIcon(String name) {
    IconData iconData = Icons.code_rounded;
    Color color = AppColors.primary;

    final lower = name.toLowerCase();
    if (lower.contains('flutter')) {
      iconData = Icons.flutter_dash_rounded;
      color = const Color(0xFF02569B);
    } else if (lower.contains('android')) {
      iconData = Icons.android_rounded;
      color = const Color(0xFF3DDC84);
    } else if (lower.contains('firebase')) {
      iconData = Icons.local_fire_department_rounded;
      color = const Color(0xFFFFCA28);
    } else if (lower.contains('sqlite') ||
        lower.contains('mysql') ||
        lower.contains('data')) {
      iconData = Icons.storage_rounded;
      color = AppColors.accent;
    } else if (lower.contains('git')) {
      iconData = Icons.merge_type_rounded;
      color = const Color(0xFFF05032);
    } else if (lower.contains('linux')) {
      iconData = Icons.terminal_rounded;
      color = Colors.amber;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, size: 20, color: color),
    );
  }
}
