import 'package:flutter_test/flutter_test.dart';
import 'package:ahmadhabibshovo/features/portfolio/data/models/profile_model.dart';
import 'package:ahmadhabibshovo/features/portfolio/data/models/project_model.dart';
import 'package:ahmadhabibshovo/features/portfolio/data/models/skill_model.dart';

void main() {
  group('ProfileModel Test', () {
    test('should parse JSON correctly into ProfileModel', () {
      final json = {
        'id': 1,
        'name': 'Ahmad Habib',
        'headline': 'Mobile App Developer',
        'bio': 'Passionate developer from Bangladesh',
        'email': 'ahmadhabibshovo@gmail.com',
        'phone': '+8801700000000',
        'location': 'Bangladesh',
        'avatar_url': 'https://example.com/avatar.png',
        'cv_url': 'https://example.com/cv.pdf',
        'github': 'https://github.com/ahmadhabibshovo',
        'linkedin': 'https://linkedin.com/in/ahmadhabibshovo',
        'facebook': 'https://fb.com/ahmadhabibshovo',
        'leetcode': 'https://leetcode.com/ahmadhabibshovo',
        'hackerearth': 'https://hackerearth.com/ahmadhabibshovo',
        'website': 'https://ahmadhabibshovo.github.io',
      };

      final model = ProfileModel.fromJson(json);

      expect(model.id, 1);
      expect(model.name, 'Ahmad Habib');
      expect(model.headline, 'Mobile App Developer');
      expect(model.email, 'ahmadhabibshovo@gmail.com');
      expect(model.location, 'Bangladesh');
    });
  });

  group('ProjectModel Test', () {
    test('should parse JSON and split techStack correctly', () {
      final json = {
        'id': 1,
        'title': 'Flutter Portfolio App',
        'slug': 'flutter-portfolio-app',
        'description': 'Clean Architecture Flutter App',
        'short_description': 'Portfolio frontend',
        'tech_stack': 'Flutter, Dart, BLoC, Go',
        'image_url': '',
        'github_url': 'https://github.com/ahmadhabibshovo',
        'live_url': '',
        'play_store_url': '',
        'category': 'Mobile',
        'is_featured': true,
        'order': 1,
      };

      final model = ProjectModel.fromJson(json);

      expect(model.title, 'Flutter Portfolio App');
      expect(model.isFeatured, true);
      expect(model.techStackList, ['Flutter', 'Dart', 'BLoC', 'Go']);
    });
  });

  group('SkillModel Test', () {
    test('should parse SkillModel from JSON', () {
      final json = {
        'id': 1,
        'name': 'Flutter',
        'category': 'Mobile App',
        'icon_url': 'https://example.com/icon.svg',
        'proficiency': 90,
        'order': 1,
      };

      final model = SkillModel.fromJson(json);

      expect(model.name, 'Flutter');
      expect(model.proficiency, 90);
      expect(model.category, 'Mobile App');
    });
  });
}
