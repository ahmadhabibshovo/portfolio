import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.headline,
    required super.bio,
    required super.email,
    required super.phone,
    required super.location,
    required super.avatarUrl,
    required super.cvUrl,
    required super.github,
    required super.linkedin,
    required super.facebook,
    required super.leetcode,
    required super.hackerearth,
    required super.website,
    super.isAvailable = true,
    super.availabilityStatus = 'Available for Mobile App Development',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Ahmad Habib',
      headline: json['headline'] as String? ?? 'Passionate Mobile Developer',
      bio: json['bio'] as String? ?? '',
      email: json['email'] as String? ?? 'ahmadhabibshovo@gmail.com',
      phone: json['phone'] as String? ?? '',
      location: json['location'] as String? ?? 'Bangladesh',
      avatarUrl: json['avatar_url'] as String? ?? '',
      cvUrl: json['cv_url'] as String? ?? '',
      github: json['github'] as String? ?? 'https://github.com/ahmadhabibshovo',
      linkedin:
          json['linkedin'] as String? ??
          'https://linkedin.com/in/ahmadhabibshovo',
      facebook: json['facebook'] as String? ?? 'https://fb.com/ahmadhabibshovo',
      leetcode:
          json['leetcode'] as String? ??
          'https://www.leetcode.com/ahmadhabibshovo',
      hackerearth:
          json['hackerearth'] as String? ??
          'https://www.hackerearth.com/ahmadhabibshovo',
      website:
          json['website'] as String? ?? 'https://ahmadhabibshovo.github.io',
      isAvailable: json['is_available'] as bool? ?? true,
      availabilityStatus:
          json['availability_status'] as String? ??
          'Available for Mobile App Development',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'headline': headline,
      'bio': bio,
      'email': email,
      'phone': phone,
      'location': location,
      'avatar_url': avatarUrl,
      'cv_url': cvUrl,
      'github': github,
      'linkedin': linkedin,
      'facebook': facebook,
      'leetcode': leetcode,
      'hackerearth': hackerearth,
      'website': website,
      'is_available': isAvailable,
      'availability_status': availabilityStatus,
    };
  }
}
