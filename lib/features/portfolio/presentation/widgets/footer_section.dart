import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/social_link_entity.dart';

class FooterSection extends StatelessWidget {
  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;
  final VoidCallback onScrollToTop;

  const FooterSection({
    super.key,
    required this.profile,
    this.socialLinks = const [],
    required this.onScrollToTop,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.cardBorder, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 36,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${profile.name}. All rights reserved.',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Text(
                        'Architected with ',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Flutter (BLoC) ',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '& ',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Go Backend',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_upward_rounded,
                  color: AppColors.primary,
                ),
                tooltip: 'Back to Top',
                onPressed: onScrollToTop,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDynamicFooterLinks(),
        ],
      ),
    );
  }

  Widget _buildDynamicFooterLinks() {
    if (socialLinks.isNotEmpty) {
      final active = socialLinks
          .where((l) => l.isActive && l.url.isNotEmpty)
          .toList();
      final children = <Widget>[];
      for (int i = 0; i < active.length; i++) {
        children.add(_buildFooterLink(active[i].platform, active[i].url));
        if (i < active.length - 1) {
          children.add(_buildSeparator());
        }
      }
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      );
    }

    // Fallback if no dynamic social links
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildFooterLink('GitHub', profile.github),
        _buildSeparator(),
        _buildFooterLink('LinkedIn', profile.linkedin),
        _buildSeparator(),
        _buildFooterLink('LeetCode', profile.leetcode),
        _buildSeparator(),
        _buildFooterLink('HackerEarth', profile.hackerearth),
        _buildSeparator(),
        _buildFooterLink('Facebook', profile.facebook),
      ],
    );
  }

  Widget _buildSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('•', style: TextStyle(color: AppColors.textMuted)),
    );
  }

  Widget _buildFooterLink(String title, String url) {
    if (url.isEmpty) return const SizedBox.shrink();
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      ),
    );
  }
}
