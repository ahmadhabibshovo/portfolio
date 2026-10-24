import '../../domain/entities/book_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/social_link_entity.dart';

/// Pre-seeded offline fallback entities for Instant 0ms load
class PortfolioInitialData {
  static ProfileEntity get defaultProfile => const ProfileEntity(
        id: 1,
        name: 'Ahmad Habib',
        headline: 'Passionate Mobile App Developer',
        bio:
            'Mobile App Developer with hands-on experience in building performant cross-platform applications using Flutter, Dart, Kotlin, and native Android, backed by robust APIs.',
        email: 'ahmadhabibshovo@gmail.com',
        phone: '',
        location: 'Bangladesh',
        avatarUrl:
            'https://raw.githubusercontent.com/ahmadhabibshovo/ahmadhabibshovo/main/avatar.png',
        cvUrl:
            'https://drive.google.com/drive/folders/1hzQIw6A21i_r0dLsY-88BlPiW50JOLN6?usp=sharing',
        github: 'https://github.com/ahmadhabibshovo',
        linkedin: 'https://linkedin.com/in/ahmadhabibshovo',
        facebook: 'https://fb.com/ahmadhabibshovo',
        leetcode: 'https://www.leetcode.com/ahmadhabibshovo',
        hackerearth: 'https://www.hackerearth.com/ahmadhabibshovo',
        website: 'https://ahmadhabibshovo.github.io',
        isAvailable: true,
        availabilityStatus: 'Available for Mobile & Fullstack Development',
      );

  static List<SocialLinkEntity> get defaultSocialLinks => const [
        SocialLinkEntity(
          id: 1,
          platform: 'GitHub',
          url: 'https://github.com/ahmadhabibshovo',
          icon: 'github',
          isActive: true,
          order: 1,
        ),
        SocialLinkEntity(
          id: 2,
          platform: 'LinkedIn',
          url: 'https://linkedin.com/in/ahmadhabibshovo',
          icon: 'linkedin',
          isActive: true,
          order: 2,
        ),
        SocialLinkEntity(
          id: 3,
          platform: 'HackerRank',
          url: 'https://www.hackerrank.com/ahmadhabibshovo',
          icon: 'hackerrank',
          isActive: true,
          order: 3,
        ),
        SocialLinkEntity(
          id: 4,
          platform: 'HackerEarth',
          url: 'https://www.hackerearth.com/ahmadhabibshovo',
          icon: 'hackerearth',
          isActive: true,
          order: 4,
        ),
        SocialLinkEntity(
          id: 5,
          platform: 'LeetCode',
          url: 'https://www.leetcode.com/ahmadhabibshovo',
          icon: 'leetcode',
          isActive: true,
          order: 5,
        ),
        SocialLinkEntity(
          id: 6,
          platform: 'Goodreads / Books',
          url: 'https://www.goodreads.com',
          icon: 'book',
          isActive: true,
          order: 6,
        ),
        SocialLinkEntity(
          id: 7,
          platform: 'Facebook',
          url: 'https://fb.com/ahmadhabibshovo',
          icon: 'facebook',
          isActive: true,
          order: 7,
        ),
      ];

  static List<BookEntity> get defaultBooks => const [
        BookEntity(
          id: 1,
          title: 'Clean Architecture',
          author: 'Robert C. Martin (Uncle Bob)',
          coverUrl:
              'https://images-na.ssl-images-amazon.com/images/I/41-sN-mzwKL._SX381_BO1,204,203,200_.jpg',
          linkUrl:
              'https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164',
          status: 'Recommended',
          rating: 5,
          review:
              'Essential software craftsmanship guide covering boundaries, entities, use cases, and decoupled presentation layers.',
          order: 1,
        ),
        BookEntity(
          id: 2,
          title: 'Designing Data-Intensive Applications',
          author: 'Martin Kleppmann',
          coverUrl:
              'https://images-na.ssl-images-amazon.com/images/I/51ZSpMl1-2L._SX379_BO1,204,203,200_.jpg',
          linkUrl:
              'https://www.amazon.com/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321',
          status: 'Currently Reading',
          rating: 5,
          review:
              'The definitive guide to distributed systems, storage engines, stream processing, and reliable backend architectures.',
          order: 2,
        ),
        BookEntity(
          id: 3,
          title: 'Flutter Complete Reference',
          author: 'Alberto Miola',
          coverUrl:
              'https://images-na.ssl-images-amazon.com/images/I/41D8WqJ2z0L.jpg',
          linkUrl:
              'https://www.amazon.com/Flutter-Complete-Reference-Create-beautiful/dp/B08KGTC746',
          status: 'Completed',
          rating: 5,
          review:
              'In-depth exploration of Dart internals, Flutter rendering pipeline, BLoC state management, and native platform channels.',
          order: 3,
        ),
      ];

  static List<HighlightEntity> get defaultHighlights => const [
        HighlightEntity(
          id: 1,
          title: 'Clean Architecture & BLoC',
          description:
              'Strict separation of concerns into Domain, Data, and Presentation layers for highly testable codebases.',
          icon: 'architecture',
          colorTag: 'primary',
          order: 1,
        ),
        HighlightEntity(
          id: 2,
          title: 'Native Performance & Optimization',
          description:
              'Crafting 60/120 FPS buttery-smooth UIs in Flutter and native Android with minimal memory footprint.',
          icon: 'speed',
          colorTag: 'secondary',
          order: 2,
        ),
        HighlightEntity(
          id: 3,
          title: 'Backend API Engineering',
          description:
              'Production Go/Gin, PostgreSQL, SQLite, JWT auth, WebSockets, and Dockerized microservices.',
          icon: 'server',
          colorTag: 'accent',
          order: 3,
        ),
        HighlightEntity(
          id: 4,
          title: 'Continuous Learning',
          description:
              'Active competitive programming on LeetCode/HackerRank, studying architecture patterns and books.',
          icon: 'book',
          colorTag: 'tertiary',
          order: 4,
        ),
      ];

  static List<SkillEntity> get defaultSkills => const [
        SkillEntity(
          id: 1,
          name: 'Flutter',
          category: 'Mobile App',
          iconUrl:
              'https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg',
          proficiency: 92,
          order: 1,
        ),
        SkillEntity(
          id: 2,
          name: 'Android',
          category: 'Mobile App',
          iconUrl:
              'https://raw.githubusercontent.com/devicons/devicon/master/icons/android/android-original-wordmark.svg',
          proficiency: 88,
          order: 2,
        ),
        SkillEntity(
          id: 3,
          name: 'Dart',
          category: 'Programming Languages',
          iconUrl:
              'https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg',
          proficiency: 90,
          order: 3,
        ),
        SkillEntity(
          id: 4,
          name: 'Kotlin',
          category: 'Programming Languages',
          iconUrl:
              'https://www.vectorlogo.zone/logos/kotlinlang/kotlinlang-icon.svg',
          proficiency: 82,
          order: 4,
        ),
        SkillEntity(
          id: 5,
          name: 'Go (Golang)',
          category: 'Programming Languages',
          iconUrl: 'https://www.vectorlogo.zone/logos/golang/golang-icon.svg',
          proficiency: 85,
          order: 5,
        ),
        SkillEntity(
          id: 6,
          name: 'SQLite',
          category: 'Databases',
          iconUrl: 'https://www.vectorlogo.zone/logos/sqlite/sqlite-icon.svg',
          proficiency: 85,
          order: 6,
        ),
        SkillEntity(
          id: 7,
          name: 'PostgreSQL',
          category: 'Databases',
          iconUrl:
              'https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original.svg',
          proficiency: 80,
          order: 7,
        ),
        SkillEntity(
          id: 8,
          name: 'Git & Docker',
          category: 'Tools & Platforms',
          iconUrl: 'https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg',
          proficiency: 88,
          order: 8,
        ),
      ];

  static List<ProjectEntity> get defaultProjects => const [
        ProjectEntity(
          id: 1,
          title: 'DriveTime: Car Sales & Dealership Platform',
          slug: 'drivetime-car-sales',
          description:
              'Comprehensive car dealership management with real-time inventory, secure messaging, in-app scheduling, and payment processing.',
          shortDescription: 'Car dealership & marketplace app',
          category: 'Mobile',
          imageUrl: 'assets/projects/drivetime.png',
          techStack: 'Flutter, Bloc, REST API, Firebase, Clean Architecture',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://play.google.com',
          playStoreUrl: 'https://play.google.com',
          isFeatured: true,
          order: 1,
        ),
        ProjectEntity(
          id: 2,
          title: 'LockZi: On-Demand Service & Security Platform',
          slug: 'lockzi-on-demand',
          description:
              'High-reliability on-demand technician dispatch and scheduling app featuring live Mapbox geolocation and tracking.',
          shortDescription: 'On-demand technician dispatch app',
          category: 'Mobile',
          imageUrl: 'assets/projects/lockzi.png',
          techStack: 'Flutter, Mapbox, WebSockets, Go, GORM',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://apps.apple.com',
          playStoreUrl: '',
          isFeatured: true,
          order: 2,
        ),
        ProjectEntity(
          id: 3,
          title: 'Frapp: Real-Time Communication App',
          slug: 'frapp-real-time-chat',
          description:
              'Modern messaging platform with end-to-end encrypted messaging, media sharing, and push notifications.',
          shortDescription: 'Encrypted real-time messaging app',
          category: 'Mobile',
          imageUrl: 'assets/projects/frapp.png',
          techStack: 'Flutter, Clean Architecture, Bloc, WebRTC',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://play.google.com',
          playStoreUrl: 'https://play.google.com',
          isFeatured: true,
          order: 3,
        ),
      ];

  static List<ExperienceEntity> get defaultExperiences => const [
        ExperienceEntity(
          id: 1,
          role: 'Mid-Level Flutter Developer',
          company: 'Tech Solutions Global',
          location: 'Dhaka, Bangladesh',
          startDate: '2023-01',
          endDate: 'Present',
          isCurrent: true,
          description:
              'Architecting, building, and deploying cross-platform applications using Flutter, Dart, BLoC, and Clean Architecture.',
          order: 1,
        ),
        ExperienceEntity(
          id: 2,
          role: 'Junior Mobile Developer',
          company: 'AppInnovate',
          location: 'Dhaka, Bangladesh',
          startDate: '2021-06',
          endDate: '2022-12',
          isCurrent: false,
          description:
              'Developed Android native and Flutter components, integrated RESTful APIs, and enhanced app stability.',
          order: 2,
        ),
      ];
}
