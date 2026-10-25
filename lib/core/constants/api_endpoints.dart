import '../config/app_config.dart';

class ApiEndpoints {
  static String get baseUrl => AppConfig.baseUrl;

  // Public Portfolio
  static String get portfolio => '$baseUrl/portfolio';
  static String get profile => '$portfolio/profile';
  static String get projects => '$portfolio/projects';
  static String projectById(String idOrSlug) => '$projects/$idOrSlug';
  static String get skills => '$portfolio/skills';
  static String get experiences => '$portfolio/experiences';
  static String get contact => '$portfolio/contact';
  static String get socialLinks => '$portfolio/social-links';
  static String get books => '$portfolio/books';
  static String get highlights => '$portfolio/highlights';

  // Auth
  static String get auth => '$baseUrl/auth';
  static String get login => '$auth/login';
  static String get register => '$auth/register';
  static String get refresh => '$auth/refresh';
  static String get logout => '$auth/logout';
  static String get userProfile => '$baseUrl/users/profile';

  // Protected Admin Management
  static String get admin => '$baseUrl/admin';
  static String get changePassword => '$admin/change-password';
  static String get adminProfile => '$admin/profile';
  static String get adminProjects => '$admin/projects';
  static String adminProjectById(int id) => '$adminProjects/$id';
  static String get adminSkills => '$admin/skills';
  static String adminSkillById(int id) => '$adminSkills/$id';
  static String get adminExperiences => '$admin/experiences';
  static String adminExperienceById(int id) => '$adminExperiences/$id';
  static String get adminMessages => '$admin/messages';
  static String adminMessageRead(int id) => '$adminMessages/$id/read';
  static String adminMessageById(int id) => '$adminMessages/$id';

  // Admin Social Links
  static String get adminSocialLinks => '$admin/social-links';
  static String adminSocialLinkById(int id) => '$adminSocialLinks/$id';

  // Admin Books
  static String get adminBooks => '$admin/books';
  static String adminBookById(int id) => '$adminBooks/$id';

  // Admin Highlights
  static String get adminHighlights => '$admin/highlights';
  static String adminHighlightById(int id) => '$adminHighlights/$id';

  // File Upload
  static String get upload => '$baseUrl/upload';
}
