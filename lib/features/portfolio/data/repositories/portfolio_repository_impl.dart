import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/social_link_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_remote_data_source.dart';
import '../models/book_model.dart';
import '../models/experience_model.dart';
import '../models/highlight_model.dart';
import '../models/profile_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/social_link_model.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profile = await remoteDataSource.getProfile();
      return Right(profile);
    } on ServerException catch (e) {
      // Fallback to default local profile if backend is not yet started
      return Right(_fallbackProfile(e.message));
    } on NetworkException catch (e) {
      return Right(_fallbackProfile(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects({
    String? category,
    bool? featured,
  }) async {
    try {
      final projects = await remoteDataSource.getProjects(
        category: category,
        featured: featured,
      );
      if (projects.isEmpty) {
        return Right(_fallbackProjects());
      }
      return Right(projects);
    } catch (_) {
      // Fallback projects
      return Right(_fallbackProjects());
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(String idOrSlug) async {
    try {
      final project = await remoteDataSource.getProjectById(idOrSlug);
      return Right(project);
    } catch (_) {
      final fallbackList = _fallbackProjects();
      final match = fallbackList.firstWhere(
        (p) => p.slug == idOrSlug || p.id.toString() == idOrSlug,
        orElse: () => fallbackList.first,
      );
      return Right(match);
    }
  }

  @override
  Future<Either<Failure, List<SkillEntity>>> getSkills({
    String? category,
  }) async {
    try {
      final skills = await remoteDataSource.getSkills(category: category);
      if (skills.isEmpty) {
        return Right(_fallbackSkills());
      }
      return Right(skills);
    } catch (_) {
      return Right(_fallbackSkills());
    }
  }

  @override
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences() async {
    try {
      final experiences = await remoteDataSource.getExperiences();
      if (experiences.isEmpty) {
        return Right(_fallbackExperiences());
      }
      return Right(experiences);
    } catch (_) {
      return Right(_fallbackExperiences());
    }
  }

  @override
  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks() async {
    try {
      final links = await remoteDataSource.getSocialLinks();
      if (links.isEmpty) {
        return Right(_fallbackSocialLinks());
      }
      return Right(links);
    } catch (_) {
      return Right(_fallbackSocialLinks());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final books = await remoteDataSource.getBooks();
      if (books.isEmpty) {
        return Right(_fallbackBooks());
      }
      return Right(books);
    } catch (_) {
      return Right(_fallbackBooks());
    }
  }

  @override
  Future<Either<Failure, List<HighlightEntity>>> getHighlights() async {
    try {
      final highlights = await remoteDataSource.getHighlights();
      if (highlights.isEmpty) {
        return Right(_fallbackHighlights());
      }
      return Right(highlights);
    } catch (_) {
      return Right(_fallbackHighlights());
    }
  }

  @override
  Future<Either<Failure, String>> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await remoteDataSource.sendContactMessage(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Graceful offline fallback matching Ahmad Habib's GitHub profile
  ProfileModel _fallbackProfile(String reason) {
    return const ProfileModel(
      id: 1,
      name: 'Ahmad Habib',
      headline: 'Passionate Mobile App Developer',
      bio: 'Passionate Mobile App Developer from Bangladesh specializing in Flutter, Dart, Android native with Kotlin, clean architecture, and reactive state management.',
      email: 'ahmadhabibshovo@gmail.com',
      phone: '+8801700000000',
      location: 'Bangladesh',
      avatarUrl: 'https://raw.githubusercontent.com/ahmadhabibshovo/ahmadhabibshovo/main/avatar.png',
      cvUrl: 'https://drive.google.com/drive/folders/1hzQIw6A21i_r0dLsY-88BlPiW50JOLN6?usp=sharing',
      github: 'https://github.com/ahmadhabibshovo',
      linkedin: 'https://linkedin.com/in/ahmadhabibshovo',
      facebook: 'https://fb.com/ahmadhabibshovo',
      leetcode: 'https://www.leetcode.com/ahmadhabibshovo',
      hackerearth: 'https://www.hackerearth.com/ahmadhabibshovo',
      website: 'https://ahmadhabibshovo.github.io',
    );
  }

  List<ProjectModel> _fallbackProjects() {
    return const [
      ProjectModel(
        id: 1,
        title: 'Flutter Portfolio App',
        slug: 'flutter-portfolio-app',
        description: 'A responsive portfolio app built with Flutter Clean Architecture, BLoC pattern, and backed by a Go REST backend.',
        shortDescription: 'Modern portfolio with live Go backend',
        techStack: 'Flutter, Dart, BLoC, Go, SQLite, Clean Architecture',
        imageUrl: '',
        githubUrl: 'https://github.com/ahmadhabibshovo/ahmadhabibshovo',
        liveUrl: 'https://ahmadhabibshovo.github.io',
        playStoreUrl: '',
        category: 'Mobile',
        isFeatured: true,
        order: 1,
      ),
      ProjectModel(
        id: 2,
        title: 'E-Commerce Mobile Application',
        slug: 'ecommerce-mobile-app',
        description: 'Feature-rich cross-platform e-commerce client with product browsing, shopping cart, authentication, and order processing.',
        shortDescription: 'Cross-platform online shopping app',
        techStack: 'Flutter, Firebase, REST API, Provider, Material 3',
        imageUrl: '',
        githubUrl: 'https://github.com/ahmadhabibshovo',
        liveUrl: '',
        playStoreUrl: '',
        category: 'Mobile',
        isFeatured: true,
        order: 2,
      ),
      ProjectModel(
        id: 3,
        title: 'Task & Habit Tracker',
        slug: 'task-habit-tracker',
        description: 'Offline-first habit and task management application featuring local SQLite caching, analytics, and reminder notifications.',
        shortDescription: 'Offline-first productivity tracker',
        techStack: 'Flutter, SQLite, Clean Architecture',
        imageUrl: '',
        githubUrl: 'https://github.com/ahmadhabibshovo',
        liveUrl: '',
        playStoreUrl: '',
        category: 'Mobile',
        isFeatured: false,
        order: 3,
      ),
    ];
  }

  List<SkillModel> _fallbackSkills() {
    return const [
      SkillModel(
        id: 1,
        name: 'Flutter',
        category: 'Mobile App',
        iconUrl:
            'https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg',
        proficiency: 92,
        order: 1,
      ),
      SkillModel(
        id: 2,
        name: 'Android',
        category: 'Mobile App',
        iconUrl: 'https://raw.githubusercontent.com/devicons/devicon/master/icons/android/android-original-wordmark.svg',
        proficiency: 88,
        order: 2,
      ),
      SkillModel(
        id: 3,
        name: 'Dart',
        category: 'Programming Languages',
        iconUrl: 'https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg',
        proficiency: 90,
        order: 3,
      ),
      SkillModel(
        id: 4,
        name: 'Kotlin',
        category: 'Programming Languages',
        iconUrl:
            'https://www.vectorlogo.zone/logos/kotlinlang/kotlinlang-icon.svg',
        proficiency: 82,
        order: 4,
      ),
      SkillModel(
        id: 5,
        name: 'Firebase',
        category: 'Databases',
        iconUrl: 'https://www.vectorlogo.zone/logos/firebase/firebase-icon.svg',
        proficiency: 85,
        order: 5,
      ),
      SkillModel(
        id: 6,
        name: 'SQLite',
        category: 'Databases',
        iconUrl: 'https://www.vectorlogo.zone/logos/sqlite/sqlite-icon.svg',
        proficiency: 85,
        order: 6,
      ),
      SkillModel(
        id: 7,
        name: 'MySQL',
        category: 'Databases',
        iconUrl: 'https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-original-wordmark.svg',
        proficiency: 78,
        order: 7,
      ),
      SkillModel(
        id: 8,
        name: 'Git',
        category: 'Tools & Platforms',
        iconUrl: 'https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg',
        proficiency: 88,
        order: 8,
      ),
      SkillModel(
        id: 9,
        name: 'Linux',
        category: 'Tools & Platforms',
        iconUrl: 'https://raw.githubusercontent.com/devicons/devicon/master/icons/linux/linux-original.svg',
        proficiency: 80,
        order: 9,
      ),
      SkillModel(
        id: 10,
        name: 'Figma',
        category: 'Tools & Platforms',
        iconUrl: 'https://www.vectorlogo.zone/logos/figma/figma-icon.svg',
        proficiency: 75,
        order: 10,
      ),
      SkillModel(
        id: 11,
        name: 'TensorFlow',
        category: 'AI/ML',
        iconUrl:
            'https://www.vectorlogo.zone/logos/tensorflow/tensorflow-icon.svg',
        proficiency: 70,
        order: 11,
      ),
    ];
  }

  List<ExperienceModel> _fallbackExperiences() {
    return const [
      ExperienceModel(
        id: 1,
        role: 'Mobile Application Developer',
        company: 'Freelance & Independent Projects',
        location: 'Dhaka, Bangladesh',
        startDate: '2023',
        endDate: 'Present',
        isCurrent: true,
        description: 'Designing and developing scalable cross-platform mobile apps using Flutter and Dart. Implementing Clean Architecture, BLoC state management, and backend REST/GraphQL integrations.',
        order: 1,
      ),
    ];
  }

  List<SocialLinkModel> _fallbackSocialLinks() {
    return const [
      SocialLinkModel(
        id: 1,
        platform: 'GitHub',
        url: 'https://github.com/ahmadhabibshovo',
        icon: 'github',
        order: 1,
      ),
      SocialLinkModel(
        id: 2,
        platform: 'LinkedIn',
        url: 'https://linkedin.com/in/ahmadhabibshovo',
        icon: 'linkedin',
        order: 2,
      ),
      SocialLinkModel(
        id: 3,
        platform: 'HackerRank',
        url: 'https://www.hackerrank.com/ahmadhabibshovo',
        icon: 'hackerrank',
        order: 3,
      ),
      SocialLinkModel(
        id: 4,
        platform: 'HackerEarth',
        url: 'https://www.hackerearth.com/ahmadhabibshovo',
        icon: 'hackerearth',
        order: 4,
      ),
      SocialLinkModel(
        id: 5,
        platform: 'LeetCode',
        url: 'https://www.leetcode.com/ahmadhabibshovo',
        icon: 'leetcode',
        order: 5,
      ),
      SocialLinkModel(
        id: 6,
        platform: 'Goodreads / Books',
        url: 'https://www.goodreads.com',
        icon: 'book',
        order: 6,
      ),
      SocialLinkModel(
        id: 7,
        platform: 'Facebook',
        url: 'https://fb.com/ahmadhabibshovo',
        icon: 'facebook',
        order: 7,
      ),
    ];
  }

  List<BookModel> _fallbackBooks() {
    return const [
      BookModel(
        id: 1,
        title: 'Clean Architecture',
        author: 'Robert C. Martin (Uncle Bob)',
        coverUrl: 'https://images-na.ssl-images-amazon.com/images/I/41-sN-mzwKL._SX381_BO1,204,203,200_.jpg',
        linkUrl: 'https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164',
        status: 'Recommended',
        rating: 5,
        review: 'Essential guide covering boundaries, entities, use cases, and decoupled presentation layers.',
        order: 1,
      ),
      BookModel(
        id: 2,
        title: 'Designing Data-Intensive Applications',
        author: 'Martin Kleppmann',
        coverUrl: 'https://images-na.ssl-images-amazon.com/images/I/51ZSpMl1-2L._SX379_BO1,204,203,200_.jpg',
        linkUrl: 'https://www.amazon.com/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321',
        status: 'Currently Reading',
        rating: 5,
        review: 'The definitive guide to distributed systems, storage engines, and reliable architectures.',
        order: 2,
      ),
    ];
  }

  List<HighlightModel> _fallbackHighlights() {
    return const [
      HighlightModel(
        id: 1,
        title: 'Clean Architecture & BLoC',
        description: 'Strict separation of concerns into Domain, Data, and Presentation layers for highly testable codebases.',
        icon: 'architecture',
        colorTag: 'primary',
        order: 1,
      ),
      HighlightModel(
        id: 2,
        title: 'Native Performance & Optimization',
        description: 'Crafting 60/120 FPS buttery-smooth UIs in Flutter and native Android with minimal memory footprint.',
        icon: 'speed',
        colorTag: 'secondary',
        order: 2,
      ),
      HighlightModel(
        id: 3,
        title: 'Fullstack Integration',
        description: 'Seamless integration with Go REST/GraphQL APIs, Firebase, SQLite offline-first databases, and WebSockets.',
        icon: 'cloud',
        colorTag: 'accent',
        order: 3,
      ),
    ];
  }
}
