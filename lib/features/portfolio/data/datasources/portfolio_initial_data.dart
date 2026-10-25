import '../../domain/entities/book_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/social_link_entity.dart';

/// Pre-seeded authentic offline fallback entities for Instant 0ms load
class PortfolioInitialData {
  static ProfileEntity get defaultProfile => const ProfileEntity(
        id: 1,
        name: 'Ahmad Habib',
        headline: 'Mid-Level Flutter Developer | Shipped 17 Production Apps',
        bio:
            'Mid-Level Flutter Developer with a proven track record of architecting, building, and launching high-performance cross-platform mobile applications. Successfully shipped and maintained 17 production apps (8 Android on Google Play and 9 iOS on App Store), with expertise in clean architecture, offline synchronization, Mapbox integrations, and payment gateways.',
        email: 'ahmadhabibshovo@gmail.com',
        phone: '01959397332',
        location: 'Wireless Gate, Mohakhali, Dhaka, Bangladesh',
        avatarUrl: 'assets/images/Habib.png',
        cvUrl:
            'https://drive.google.com/drive/folders/1hzQIw6A21i_r0dLsY-88BlPiW50JOLN6?usp=sharing',
        github: 'https://github.com/ahmadhabibshovo',
        linkedin: 'https://www.linkedin.com/in/ahmadhabibshovo/',
        facebook: 'https://www.facebook.com/ahmadhabibshovo',
        leetcode: 'https://leetcode.com/u/ahmadhabibshovo/',
        hackerearth: '',
        website: 'https://ahmadhabibshovo.github.io',
        isAvailable: true,
        availabilityStatus: 'Available for Mobile & Fullstack Opportunities',
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
          url: 'https://www.linkedin.com/in/ahmadhabibshovo/',
          icon: 'linkedin',
          isActive: true,
          order: 2,
        ),
        SocialLinkEntity(
          id: 3,
          platform: 'LeetCode',
          url: 'https://leetcode.com/u/ahmadhabibshovo/',
          icon: 'leetcode',
          isActive: true,
          order: 3,
        ),
        SocialLinkEntity(
          id: 4,
          platform: 'HackerRank',
          url: 'https://www.hackerrank.com/ahmadhabibshovo',
          icon: 'hackerrank',
          isActive: true,
          order: 4,
        ),
        SocialLinkEntity(
          id: 5,
          platform: 'Facebook',
          url: 'https://www.facebook.com/ahmadhabibshovo',
          icon: 'facebook',
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
          title: '17 Production Apps Shipped',
          description:
              'Successfully deployed 8 Android apps to Google Play and 9 iOS apps to the Apple App Store with full lifecycle management.',
          icon: 'mobile',
          colorTag: '#00F0FF',
          order: 1,
        ),
        HighlightEntity(
          id: 2,
          title: 'Clean Architecture & BLoC',
          description:
              'Layered Domain-Driven Design, strict separation of concerns, repository patterns, and robust reactive state flow.',
          icon: 'architecture',
          colorTag: '#7928CA',
          order: 2,
        ),
        HighlightEntity(
          id: 3,
          title: 'Offline Sync & Mapbox',
          description:
              'Advanced offline map tile downloading, two-way SQLite/Sqflite synchronization, and Grasshopper motorcycle routing engines.',
          icon: 'database',
          colorTag: '#10B981',
          order: 3,
        ),
        HighlightEntity(
          id: 4,
          title: 'Payments & Subscriptions',
          description:
              'Production in-app purchases (IAP), Stripe, RevenueCat, PayTabs, WooCommerce REST API integrations, and secure checkout.',
          icon: 'wallet',
          colorTag: '#F59E0B',
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
          proficiency: 95,
          order: 1,
        ),
        SkillEntity(
          id: 2,
          name: 'Dart',
          category: 'Programming Languages',
          iconUrl:
              'https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg',
          proficiency: 92,
          order: 2,
        ),
        SkillEntity(
          id: 3,
          name: 'Android Dev',
          category: 'Mobile App',
          iconUrl:
              'https://raw.githubusercontent.com/devicons/devicon/master/icons/android/android-original-wordmark.svg',
          proficiency: 88,
          order: 3,
        ),
        SkillEntity(
          id: 4,
          name: 'iOS Dev',
          category: 'Mobile App',
          iconUrl:
              'https://raw.githubusercontent.com/devicons/devicon/master/icons/apple/apple-original.svg',
          proficiency: 85,
          order: 4,
        ),
        SkillEntity(
          id: 5,
          name: 'Riverpod / BLoC / Provider',
          category: 'State Management',
          iconUrl: 'assets/state_icon.png',
          proficiency: 92,
          order: 5,
        ),
        SkillEntity(
          id: 6,
          name: 'Clean Architecture / SOLID',
          category: 'Architecture',
          iconUrl: 'assets/architecture_icon.png',
          proficiency: 95,
          order: 6,
        ),
        SkillEntity(
          id: 7,
          name: 'Sqflite / Hive Offline Sync',
          category: 'Databases',
          iconUrl: 'assets/database_icon.png',
          proficiency: 90,
          order: 7,
        ),
        SkillEntity(
          id: 8,
          name: 'Mapbox / Google Maps',
          category: 'Integrations',
          iconUrl: 'assets/maps_icon.png',
          proficiency: 90,
          order: 8,
        ),
        SkillEntity(
          id: 9,
          name: 'Stripe / RevenueCat / IAP',
          category: 'Payments',
          iconUrl: 'assets/payments_icon.png',
          proficiency: 88,
          order: 9,
        ),
        SkillEntity(
          id: 10,
          name: 'REST APIs / Firebase',
          category: 'Backend & APIs',
          iconUrl: 'assets/firebase_icon.png',
          proficiency: 92,
          order: 10,
        ),
        SkillEntity(
          id: 11,
          name: 'Go (Golang)',
          category: 'Programming Languages',
          iconUrl: 'https://www.vectorlogo.zone/logos/golang/golang-icon.svg',
          proficiency: 85,
          order: 11,
        ),
        SkillEntity(
          id: 12,
          name: 'Git & Docker',
          category: 'Tools & Platforms',
          iconUrl: 'https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg',
          proficiency: 88,
          order: 12,
        ),
      ];

  static List<ProjectEntity> get defaultProjects => const [
        ProjectEntity(
          id: 1,
          title: 'Rv way',
          slug: 'rv-way',
          description:
              'Navigation and travel companion app featuring Mapbox routing, In-App Purchases (IAP) subscriptions, Google AdMob monetization, and AI chatting assistant integration.',
          shortDescription:
              'Mapbox routing & AI travel app with IAP subscriptions',
          category: 'Mobile',
          imageUrl: 'assets/projects/rv_way.png',
          techStack: 'Flutter, Mapbox, In-App Purchase, AdMob, AI Chatbot',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://apps.apple.com/mo/app/rvway/id6759445243',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.rvway.app',
          isFeatured: true,
          order: 1,
        ),
        ProjectEntity(
          id: 2,
          title: 'Moto Master App',
          slug: 'moto-master-app',
          description:
              'Custom motorcycle navigation app featuring IAP subscription, Mapbox and Grasshopper map routing engine for custom motorcycle routes, offline support, and speed limits.',
          shortDescription:
              'Custom motorcycle routing app with Mapbox & Grasshopper',
          category: 'Mobile',
          imageUrl: 'assets/projects/moto_master.png',
          techStack: 'Flutter, Mapbox, Grasshopper Routing, IAP, SQLite',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://apps.apple.com/us/app/moto-master/id6755039384',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.moto.master',
          isFeatured: true,
          order: 2,
        ),
        ProjectEntity(
          id: 3,
          title: 'TimberNet',
          slug: 'timbernet',
          description:
              'Forestry management mobile application featuring offline Mapbox map tile downloading, GPS tracking, and two-way online/offline synchronization using SQLite and REST APIs.',
          shortDescription:
              'Offline forestry management with Mapbox & SQLite sync',
          category: 'Mobile',
          imageUrl: 'assets/projects/timbernet.png',
          techStack:
              'Flutter, Mapbox Offline, SQLite, REST API, Background GPS',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl:
              'https://apps.apple.com/us/app/timbernet-mobile/id6749359970',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=de.kazmos.timbernet&pcampaignid=web_share',
          isFeatured: true,
          order: 3,
        ),
        ProjectEntity(
          id: 4,
          title: 'Rovascore Live Scores',
          slug: 'rovascore-live-scores',
          description:
              'Fast live sports scores and football news application with real-time match events, push notifications, and Google AdMob banner/interstitial integration.',
          shortDescription: 'Real-time sports scores, statistics & news',
          category: 'Mobile',
          imageUrl: 'assets/projects/rovascore.png',
          techStack: 'Flutter, WebSockets, Firebase Cloud Messaging, AdMob',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl:
              'https://apps.apple.com/us/app/rovascore-live-scores-news/id6756863993',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.rovascore.app&pcampaignid=web_share',
          isFeatured: true,
          order: 4,
        ),
        ProjectEntity(
          id: 5,
          title: 'Sell Your Strips',
          slug: 'sell-your-strips',
          description:
              'E-commerce medical supplies platform powered by WordPress WooCommerce REST APIs, custom payment gateways, order tracking, and specialized state management.',
          shortDescription:
              'WooCommerce e-commerce app with payment gateway',
          category: 'Mobile',
          imageUrl: 'assets/projects/sell_your_strips.png',
          techStack:
              'Flutter, WooCommerce REST API, WordPress, Payment Gateways',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl:
              'https://apps.apple.com/us/app/sell-your-strips/id6751053534?platform=iphone',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.sellyourstripsusa.app&pcampaignid=web_share',
          isFeatured: true,
          order: 5,
        ),
        ProjectEntity(
          id: 6,
          title: 'Frapp',
          slug: 'frapp',
          description:
              'All-in-one community platform connecting creators, students, and learners for personal branding, mentorship, project collaboration, and exclusive educational content.',
          shortDescription:
              'Creator & student mentorship community platform',
          category: 'Mobile',
          imageUrl: 'assets/projects/frapp.png',
          techStack: 'Flutter, Clean Architecture, BLoC, WebRTC, Firebase',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl:
              'https://apps.apple.com/us/app/frapp-discover-connect-grow/id6759274038',
          playStoreUrl:
              'https://apps.apple.com/us/app/frapp-discover-connect-grow/id6759274038',
          isFeatured: true,
          order: 6,
        ),
        ProjectEntity(
          id: 7,
          title: 'Lockzi',
          slug: 'lockzi',
          description:
              'Business platform empowering content creators to securely share and sell digital media directly to their audience with digital rights management and instant payouts.',
          shortDescription:
              'Digital content monetization platform for creators',
          category: 'Mobile',
          imageUrl: 'assets/projects/lockzi.png',
          techStack:
              'Flutter, Stripe Payments, Cloud Storage, Go Backend, JWT',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://apps.apple.com/us/app/lockzi/id6768182674',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=ac.lockzi.app&pcampaignid=web_share',
          isFeatured: true,
          order: 7,
        ),
        ProjectEntity(
          id: 8,
          title: 'DriveTime',
          slug: 'drivetime',
          description:
              'Centralized delivery and driver operations dashboard for restaurants, featuring real-time tracking, weekly scheduling, driver coordination, and role-based access control.',
          shortDescription:
              'Delivery dispatch & driver management operations app',
          category: 'Mobile',
          imageUrl: 'assets/projects/drivetime.png',
          techStack: 'Flutter, BLoC, Geolocation, REST API, FCM',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://apps.apple.com/za/app/drivetime-io/id6764275003',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=io.drivetime.app&pcampaignid=web_share',
          isFeatured: true,
          order: 8,
        ),
        ProjectEntity(
          id: 9,
          title: 'Masadari',
          slug: 'masadari',
          description:
              'Educational marketplace (LMS) for teachers and students to buy/sell digital educational resources with PayTabs integration and multi-language Arabic/English support.',
          shortDescription:
              'LMS educational marketplace with PayTabs payment',
          category: 'Mobile',
          imageUrl: 'assets/projects/masadari.png',
          techStack:
              'Flutter, PayTabs, Localization, REST API, PDF Viewer',
          githubUrl: 'https://github.com/ahmadhabibshovo',
          liveUrl: 'https://apps.apple.com/us/app/masadri/id6741678339',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.masadrimobile.app&pcampaignid=web_share',
          isFeatured: true,
          order: 9,
        ),
        ProjectEntity(
          id: 10,
          title: 'Photo Gallery',
          slug: 'photo-gallery',
          description:
              'Responsive photo gallery web application demonstrating categorized galleries, responsive masonry grid layout, and caption management.',
          shortDescription: 'Photo display web app with captions',
          category: 'Web',
          imageUrl: 'assets/projects/01.png',
          techStack: 'Flutter Web, Netlify, Responsive Grid',
          githubUrl: 'https://github.com/ahmadhabibshovo/PhotoGallery',
          liveUrl: 'https://photogalleryprv.netlify.app',
          playStoreUrl: '',
          isFeatured: false,
          order: 10,
        ),
        ProjectEntity(
          id: 11,
          title: 'Flutter Meals',
          slug: 'flutter-meals',
          description:
              'Recipe and meal planning application showcasing recipe categories, nutritional information, step-by-step cooking instructions, and favorites.',
          shortDescription: 'Meals & recipe exploration web app',
          category: 'Web',
          imageUrl: 'assets/projects/02.png',
          techStack: 'Flutter Web, State Management, Netlify',
          githubUrl: 'https://github.com/ahmadhabibshovo/Flutter_Meals',
          liveUrl: 'https://flutter-meal.netlify.app/',
          playStoreUrl: '',
          isFeatured: false,
          order: 11,
        ),
        ProjectEntity(
          id: 12,
          title: 'BMI Calculator',
          slug: 'bmi-calculator',
          description:
              'Interactive health and body mass index calculator with animated gauge feedback and personalized health recommendations.',
          shortDescription: 'Interactive body mass index calculator',
          category: 'Web',
          imageUrl: 'assets/projects/03.png',
          techStack: 'Flutter Web, Custom Painters, Netlify',
          githubUrl: 'https://github.com/ahmadhabibshovo/bmi_calculator',
          liveUrl: 'https://bmicalculatorprv.netlify.app/',
          playStoreUrl: '',
          isFeatured: false,
          order: 12,
        ),
        ProjectEntity(
          id: 13,
          title: 'Expense Tracker',
          slug: 'expense-tracker',
          description:
              'Personal finance and budget tracker with dynamic spending bar charts, modal entry forms, and category filtering.',
          shortDescription: 'Personal budget tracker with spending charts',
          category: 'Web',
          imageUrl: 'assets/projects/04.png',
          techStack: 'Flutter Web, Charts, Netlify',
          githubUrl: 'https://github.com/ahmadhabibshovo/expense_tracker',
          liveUrl: 'https://prvexpensetracker.netlify.app/',
          playStoreUrl: '',
          isFeatured: false,
          order: 13,
        ),
        ProjectEntity(
          id: 14,
          title: 'Todo App',
          slug: 'todo-app',
          description:
              'Task manager application featuring drag-to-complete, persistent checklist, task categorization, and priority tagging.',
          shortDescription: 'Task and to-do checklist web app',
          category: 'Web',
          imageUrl: 'assets/projects/05.png',
          techStack: 'Flutter Web, Netlify, Local Storage',
          githubUrl: 'https://github.com/ahmadhabibshovo/todo_app',
          liveUrl: 'https://prvtodoapp.netlify.app/',
          playStoreUrl: '',
          isFeatured: false,
          order: 14,
        ),
        ProjectEntity(
          id: 15,
          title: 'Calculator',
          slug: 'calculator',
          description:
              'Sleek dark-themed scientific and arithmetic calculator with formula history evaluation.',
          shortDescription: 'Arithmetic and scientific calculator',
          category: 'Web',
          imageUrl: 'assets/projects/06.png',
          techStack: 'Flutter Web, Math Expressions, Netlify',
          githubUrl: 'https://github.com/ahmadhabibshovo/caluator',
          liveUrl: 'https://prevcalculator.netlify.app/',
          playStoreUrl: '',
          isFeatured: false,
          order: 15,
        ),
      ];

  static List<ExperienceEntity> get defaultExperiences => const [
        ExperienceEntity(
          id: 1,
          role: 'Flutter Stack Lead',
          company: 'Softvence Agency',
          location: 'Dhaka, Bangladesh',
          startDate: '2024',
          endDate: 'Present',
          isCurrent: true,
          description:
              'Managed and led the end-to-end development of 17+ cross-platform mobile applications. Successfully deployed 8 Android applications to Google Play and 9 iOS applications to the Apple App Store. Directly engaged with foreign clients to understand project needs, manage implementations, and oversee client communications.',
          order: 1,
        ),
        ExperienceEntity(
          id: 2,
          role: 'B.Sc. in Computer Science and Engineering',
          company: 'Manarat International University',
          location: 'Dhaka, Bangladesh',
          startDate: '2019',
          endDate: '2023',
          isCurrent: false,
          description:
              'Graduated with CGPA 3.41. Advanced coursework in Algorithms, Data Structures, Mobile Application Architecture, Distributed Systems, and Low-Level System Design.',
          order: 2,
        ),
      ];
}
