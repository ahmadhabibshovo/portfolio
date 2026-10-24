import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/icon_resolver.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/social_link_entity.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onAboutTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onExperienceTap;
  final VoidCallback? onBooksTap;
  final VoidCallback onContactTap;
  final List<SocialLinkEntity> socialLinks;

  const NavBar({
    super.key,
    required this.onAboutTap,
    required this.onSkillsTap,
    required this.onProjectsTap,
    required this.onExperienceTap,
    this.onBooksTap,
    required this.onContactTap,
    this.socialLinks = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.9),
        border: const Border(
          bottom: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo / Brand
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'AH',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Ahmad Habib',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          // Nav Items
          if (Responsive.isDesktop(context))
            Row(
              children: [
                _NavLink(title: 'About', onTap: onAboutTap),
                _NavLink(title: 'Skills', onTap: onSkillsTap),
                _NavLink(title: 'Projects', onTap: onProjectsTap),
                if (onBooksTap != null)
                  _NavLink(title: 'Books', onTap: onBooksTap!),
                _NavLink(title: 'Experience', onTap: onExperienceTap),
                _NavLink(title: 'Contact', onTap: onContactTap),
                const SizedBox(width: 12),
                ..._buildTopSocialShortcuts(),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                  tooltip: 'Admin Portal',
                  onPressed: () => Navigator.pushNamed(context, '/admin'),
                ),
              ],
            )
          else if (Responsive.isTablet(context))
            Row(
              children: [
                _NavLink(title: 'About', onTap: onAboutTap),
                _NavLink(title: 'Skills', onTap: onSkillsTap),
                _NavLink(title: 'Projects', onTap: onProjectsTap),
                if (onBooksTap != null)
                  _NavLink(title: 'Books', onTap: onBooksTap!),
                _NavLink(title: 'Contact', onTap: onContactTap),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                  tooltip: 'Admin Portal',
                  onPressed: () => Navigator.pushNamed(context, '/admin'),
                ),
              ],
            )
          else
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                  tooltip: 'Admin Portal',
                  onPressed: () => Navigator.pushNamed(context, '/admin'),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.mail_outline,
                    color: AppColors.primary,
                  ),
                  onPressed: onContactTap,
                ),
              ],
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTopSocialShortcuts() {
    final active = socialLinks
        .where((l) => l.isActive && l.url.isNotEmpty)
        .take(3)
        .toList();
    if (active.isEmpty) {
      return [
        IconButton(
          icon: AppIconResolver.getIcon(
            'github',
            size: 18,
            color: AppColors.textPrimary,
          ),
          tooltip: 'GitHub',
          onPressed: () => _launch('https://github.com/ahmadhabibshovo'),
        ),
      ];
    }

    return active.map((link) {
      return IconButton(
        icon: AppIconResolver.getIcon(
          link.icon,
          size: 18,
          color: AppColors.textPrimary,
        ),
        tooltip: link.platform,
        onPressed: () => _launch(link.url),
      );
    }).toList();
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
