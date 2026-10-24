import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/icon_resolver.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/profile_entity.dart';

class AboutSection extends StatelessWidget {
  final ProfileEntity profile;
  final List<HighlightEntity> highlights;

  const AboutSection({
    super.key,
    required this.profile,
    this.highlights = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('ABOUT ME', 'Architecting Scalable Mobile Apps'),
          const SizedBox(height: 32),
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildBioCard()),
                const SizedBox(width: 24),
                Expanded(child: _buildHighlightsGrid()),
              ],
            ),
            mobile: Column(
              children: [
                _buildBioCard(),
                const SizedBox(height: 24),
                _buildHighlightsGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String tag, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBioCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.person_pin_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                SizedBox(width: 12),
                Text(
                  'Who I Am',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              profile.bio,
              style: const TextStyle(
                fontSize: 15,
                height: 1.7,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.cardBorder),
            const SizedBox(height: 20),
            _buildDetailRow(
              Icons.location_on_outlined,
              'Location',
              profile.location,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.email_outlined, 'Email', profile.email),
            if (profile.phone.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildDetailRow(Icons.phone_outlined, 'Phone', profile.phone),
            ],
            const SizedBox(height: 12),
            _buildDetailRow(Icons.language_rounded, 'Website', profile.website),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightsGrid() {
    if (highlights.isNotEmpty) {
      return Column(
        children: highlights.map((h) {
          final color = _resolveColor(h.colorTag);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildHighlightCard(
              icon: AppIconResolver.getMaterialIcon(h.icon),
              title: h.title,
              description: h.description,
              color: color,
            ),
          );
        }).toList(),
      );
    }

    // Default Fallback Highlights
    return Column(
      children: [
        _buildHighlightCard(
          icon: Icons.architecture_rounded,
          title: 'Clean Architecture & BLoC',
          description: 'Strict separation of concerns into Domain, Data, and Presentation layers for highly testable and maintainable codebases.',
          color: AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildHighlightCard(
          icon: Icons.speed_rounded,
          title: 'Native Performance & Optimization',
          description: 'Crafting 60/120 FPS buttery-smooth UIs in Flutter and native Android with minimal memory footprint.',
          color: AppColors.secondary,
        ),
        const SizedBox(height: 16),
        _buildHighlightCard(
          icon: Icons.cloud_sync_rounded,
          title: 'Fullstack Integration',
          description: 'Seamless integration with Go REST/GraphQL APIs, Firebase, SQLite offline-first databases, and WebSockets.',
          color: AppColors.accent,
        ),
      ],
    );
  }

  Color _resolveColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'secondary':
        return AppColors.secondary;
      case 'accent':
        return AppColors.accent;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildHighlightCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
