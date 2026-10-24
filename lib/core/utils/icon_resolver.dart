import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconOption {
  final String key;
  final String label;
  final dynamic icon;

  const IconOption({
    required this.key,
    required this.label,
    required this.icon,
  });
}

class AppIconResolver {
  static const List<IconOption> availableIcons = [
    IconOption(key: 'github', label: 'GitHub', icon: FontAwesomeIcons.github),
    IconOption(
      key: 'linkedin',
      label: 'LinkedIn',
      icon: FontAwesomeIcons.linkedin,
    ),
    IconOption(
      key: 'hackerrank',
      label: 'HackerRank',
      icon: FontAwesomeIcons.hackerrank,
    ),
    IconOption(
      key: 'hackerearth',
      label: 'HackerEarth',
      icon: FontAwesomeIcons.laptopCode,
    ),
    IconOption(key: 'leetcode', label: 'LeetCode', icon: FontAwesomeIcons.code),
    IconOption(
      key: 'book',
      label: 'Book / Reading',
      icon: FontAwesomeIcons.bookOpen,
    ),
    IconOption(
      key: 'goodreads',
      label: 'Goodreads',
      icon: FontAwesomeIcons.bookBookmark,
    ),
    IconOption(
      key: 'twitter',
      label: 'Twitter / X',
      icon: FontAwesomeIcons.xTwitter,
    ),
    IconOption(
      key: 'youtube',
      label: 'YouTube',
      icon: FontAwesomeIcons.youtube,
    ),
    IconOption(key: 'medium', label: 'Medium', icon: FontAwesomeIcons.medium),
    IconOption(
      key: 'discord',
      label: 'Discord',
      icon: FontAwesomeIcons.discord,
    ),
    IconOption(
      key: 'codeforces',
      label: 'Codeforces',
      icon: FontAwesomeIcons.chartLine,
    ),
    IconOption(key: 'kaggle', label: 'Kaggle', icon: FontAwesomeIcons.kaggle),
    IconOption(
      key: 'facebook',
      label: 'Facebook',
      icon: FontAwesomeIcons.facebook,
    ),
    IconOption(
      key: 'globe',
      label: 'Website / Web',
      icon: FontAwesomeIcons.globe,
    ),
    IconOption(
      key: 'terminal',
      label: 'Terminal / CLI',
      icon: Icons.terminal_rounded,
    ),
    IconOption(
      key: 'architecture',
      label: 'Architecture',
      icon: Icons.architecture_rounded,
    ),
    IconOption(
      key: 'speed',
      label: 'Performance / Speed',
      icon: Icons.speed_rounded,
    ),
    IconOption(
      key: 'cloud',
      label: 'Cloud / API',
      icon: Icons.cloud_sync_rounded,
    ),
    IconOption(
      key: 'mobile',
      label: 'Mobile / Phone',
      icon: Icons.phone_android_rounded,
    ),
    IconOption(key: 'database', label: 'Database', icon: Icons.storage_rounded),
    IconOption(
      key: 'security',
      label: 'Security / Shield',
      icon: Icons.security_rounded,
    ),
    IconOption(key: 'star', label: 'Star / Featured', icon: Icons.star_rounded),
  ];

  static Widget getIcon(String key, {double size = 20, Color? color}) {
    final lowerKey = key.trim().toLowerCase();

    // Map known font awesome icons
    switch (lowerKey) {
      case 'github':
        return FaIcon(FontAwesomeIcons.github, size: size, color: color);
      case 'linkedin':
        return FaIcon(FontAwesomeIcons.linkedin, size: size, color: color);
      case 'hackerrank':
        return FaIcon(FontAwesomeIcons.hackerrank, size: size, color: color);
      case 'hackerearth':
        return FaIcon(FontAwesomeIcons.laptopCode, size: size, color: color);
      case 'leetcode':
        return FaIcon(FontAwesomeIcons.code, size: size, color: color);
      case 'book':
      case 'books':
        return FaIcon(FontAwesomeIcons.bookOpen, size: size, color: color);
      case 'goodreads':
        return FaIcon(FontAwesomeIcons.bookBookmark, size: size, color: color);
      case 'twitter':
      case 'x':
        return FaIcon(FontAwesomeIcons.xTwitter, size: size, color: color);
      case 'youtube':
        return FaIcon(FontAwesomeIcons.youtube, size: size, color: color);
      case 'medium':
        return FaIcon(FontAwesomeIcons.medium, size: size, color: color);
      case 'discord':
        return FaIcon(FontAwesomeIcons.discord, size: size, color: color);
      case 'codeforces':
        return FaIcon(FontAwesomeIcons.chartLine, size: size, color: color);
      case 'kaggle':
        return FaIcon(FontAwesomeIcons.kaggle, size: size, color: color);
      case 'facebook':
        return FaIcon(FontAwesomeIcons.facebook, size: size, color: color);
      case 'globe':
      case 'website':
        return FaIcon(FontAwesomeIcons.globe, size: size, color: color);
      case 'terminal':
        return Icon(Icons.terminal_rounded, size: size, color: color);
      case 'architecture':
        return Icon(Icons.architecture_rounded, size: size, color: color);
      case 'speed':
        return Icon(Icons.speed_rounded, size: size, color: color);
      case 'cloud':
        return Icon(Icons.cloud_sync_rounded, size: size, color: color);
      case 'mobile':
        return Icon(Icons.phone_android_rounded, size: size, color: color);
      case 'database':
        return Icon(Icons.storage_rounded, size: size, color: color);
      case 'security':
        return Icon(Icons.security_rounded, size: size, color: color);
      case 'star':
        return Icon(Icons.star_rounded, size: size, color: color);
      default:
        return Icon(Icons.link_rounded, size: size, color: color);
    }
  }

  static IconData getMaterialIcon(String key) {
    switch (key.toLowerCase()) {
      case 'architecture':
        return Icons.architecture_rounded;
      case 'speed':
        return Icons.speed_rounded;
      case 'cloud':
        return Icons.cloud_sync_rounded;
      case 'mobile':
        return Icons.phone_android_rounded;
      case 'database':
        return Icons.storage_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'terminal':
        return Icons.terminal_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
