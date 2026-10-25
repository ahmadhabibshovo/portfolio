import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/icon_resolver.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_shimmer.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/social_link_entity.dart';

class HeroSection extends StatelessWidget {
  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.profile,
    this.socialLinks = const [],
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: isDesktop ? 80 : 40,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: _buildContent(context)),
                const SizedBox(width: 48),
                Expanded(flex: 2, child: _buildAvatar()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAvatar(),
                const SizedBox(height: 36),
                _buildContent(context, centered: true),
              ],
            ),
    );
  }

  Widget _buildContent(BuildContext context, {bool centered = false}) {
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Dynamic Availability Pill
        if (profile.isAvailable)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 4,
                  backgroundColor: AppColors.accent,
                ),
                const SizedBox(width: 8),
                Text(
                  profile.availabilityStatus.isNotEmpty
                      ? profile.availabilityStatus
                      : 'Available for Opportunities',
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        if (profile.isAvailable) const SizedBox(height: 24),

        // Headline
        Text(
          "Hi, I'm ${profile.name}",
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displayLarge
              ?.copyWith(fontSize: centered ? 34 : 48),
        ),
        const SizedBox(height: 12),

        // Subtitle with Gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            profile.headline,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Bio
        Text(
          profile.bio,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: onProjectsTap,
              icon: const Icon(Icons.code, size: 18),
              label: const Text('View Projects'),
            ),
            OutlinedButton.icon(
              onPressed: onContactTap,
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text('Get in Touch'),
            ),
            if (profile.cvUrl.isNotEmpty)
              OutlinedButton.icon(
                onPressed: () => _launch(profile.cvUrl),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download CV'),
              ),
          ],
        ),
        const SizedBox(height: 36),

        // Dynamic Social & Platform Links
        _buildSocialLinks(centered),
      ],
    );
  }

  Widget _buildSocialLinks(bool centered) {
    if (socialLinks.isNotEmpty) {
      final activeLinks = socialLinks
          .where((l) => l.isActive && l.url.isNotEmpty)
          .toList();
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: centered ? WrapAlignment.center : WrapAlignment.start,
        children: activeLinks.map((link) {
          return _DynamicSocialIconButton(
            iconKey: link.icon,
            tooltip: link.platform,
            url: link.url,
          );
        }).toList(),
      );
    }

    // Fallback if no dynamic social links populated yet
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: centered ? WrapAlignment.center : WrapAlignment.start,
      children: [
        if (profile.github.isNotEmpty)
          _DynamicSocialIconButton(
            iconKey: 'github',
            tooltip: 'GitHub',
            url: profile.github,
          ),
        if (profile.linkedin.isNotEmpty)
          _DynamicSocialIconButton(
            iconKey: 'linkedin',
            tooltip: 'LinkedIn',
            url: profile.linkedin,
          ),
        if (profile.leetcode.isNotEmpty)
          _DynamicSocialIconButton(
            iconKey: 'leetcode',
            tooltip: 'LeetCode',
            url: profile.leetcode,
          ),
        if (profile.hackerearth.isNotEmpty)
          _DynamicSocialIconButton(
            iconKey: 'hackerearth',
            tooltip: 'HackerEarth',
            url: profile.hackerearth,
          ),
        if (profile.facebook.isNotEmpty)
          _DynamicSocialIconButton(
            iconKey: 'facebook',
            tooltip: 'Facebook',
            url: profile.facebook,
          ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 40,
              spreadRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
          ),
          clipBehavior: Clip.antiAlias,
          child: profile.avatarUrl.isNotEmpty
              ? Image.network(
                  profile.avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _buildFallbackAvatar(),
                )
              : _buildFallbackAvatar(),
        ),
      ),
    );
  }

  Widget _buildAvatarImage() {
    final avatar = profile.avatarUrl.trim();

    if (avatar.startsWith('http://') || avatar.startsWith('https://')) {
      return Image.network(
        avatar,
        fit: BoxFit.cover,
        width: 250,
        height: 250,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }
          return const AppShimmer(
            child: ShimmerCircle(size: 250),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const AppShimmer(
            child: ShimmerCircle(size: 250),
          );
        },
        errorBuilder: (_, _, _) => _buildLocalOrFallbackAvatar(),
      );
    }

    if (avatar.startsWith('assets/')) {
      return Image.asset(
        avatar,
        fit: BoxFit.cover,
        width: 250,
        height: 250,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }
          return const AppShimmer(
            child: ShimmerCircle(size: 250),
          );
        },
        errorBuilder: (_, _, _) => _buildFallbackAvatar(),
      );
    }

    return _buildLocalOrFallbackAvatar();
  }

  Widget _buildLocalOrFallbackAvatar() {
    return Image.asset(
      'assets/images/Habib.png',
      fit: BoxFit.cover,
      width: 250,
      height: 250,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return const AppShimmer(
          child: ShimmerCircle(size: 250),
        );
      },
      errorBuilder: (_, _, _) => _buildFallbackAvatar(),
    );
  }

  Widget _buildFallbackAvatar() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.terminal_rounded, size: 64, color: AppColors.primary),
          SizedBox(height: 8),
          Text(
            'Flutter & Go',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _DynamicSocialIconButton extends StatelessWidget {
  final String iconKey;
  final String tooltip;
  final String url;

  const _DynamicSocialIconButton({
    required this.iconKey,
    required this.tooltip,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return const SizedBox.shrink();

    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: AppIconResolver.getIcon(
            iconKey,
            size: 18,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
