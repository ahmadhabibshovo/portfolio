import 'package:equatable/equatable.dart';

class SocialLinkEntity extends Equatable {
  final int id;
  final String platform;
  final String url;
  final String icon;
  final bool isActive;
  final int order;

  const SocialLinkEntity({
    required this.id,
    required this.platform,
    required this.url,
    required this.icon,
    this.isActive = true,
    this.order = 0,
  });

  @override
  List<Object?> get props => [id, platform, url, icon, isActive, order];
}
