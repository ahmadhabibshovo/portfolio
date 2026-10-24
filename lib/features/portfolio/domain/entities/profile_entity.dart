import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int id;
  final String name;
  final String headline;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final String avatarUrl;
  final String cvUrl;
  final String github;
  final String linkedin;
  final String facebook;
  final String leetcode;
  final String hackerearth;
  final String website;
  final bool isAvailable;
  final String availabilityStatus;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.headline,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    required this.avatarUrl,
    required this.cvUrl,
    required this.github,
    required this.linkedin,
    required this.facebook,
    required this.leetcode,
    required this.hackerearth,
    required this.website,
    this.isAvailable = true,
    this.availabilityStatus = 'Available for Mobile App Development',
  });

  @override
  List<Object?> get props => [
    id,
    name,
    headline,
    bio,
    email,
    phone,
    location,
    avatarUrl,
    cvUrl,
    github,
    linkedin,
    facebook,
    leetcode,
    hackerearth,
    website,
    isAvailable,
    availabilityStatus,
  ];
}
