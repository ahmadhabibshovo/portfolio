import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/social_link_entity.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/get_experiences_usecase.dart';
import '../../domain/usecases/get_highlights_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/get_skills_usecase.dart';
import '../../domain/usecases/get_social_links_usecase.dart';
import '../../domain/usecases/send_contact_message_usecase.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetProfileUseCase getProfileUseCase;
  final GetProjectsUseCase getProjectsUseCase;
  final GetSkillsUseCase getSkillsUseCase;
  final GetExperiencesUseCase getExperiencesUseCase;
  final GetSocialLinksUseCase getSocialLinksUseCase;
  final GetBooksUseCase getBooksUseCase;
  final GetHighlightsUseCase getHighlightsUseCase;
  final SendContactMessageUseCase sendContactMessageUseCase;

  PortfolioBloc({
    required this.getProfileUseCase,
    required this.getProjectsUseCase,
    required this.getSkillsUseCase,
    required this.getExperiencesUseCase,
    required this.getSocialLinksUseCase,
    required this.getBooksUseCase,
    required this.getHighlightsUseCase,
    required this.sendContactMessageUseCase,
  }) : super(PortfolioLoaded.initial(isSyncing: true)) {
    on<FetchPortfolioDataEvent>(_onFetchData);
    on<FilterProjectsByCategoryEvent>(_onFilterProjects);
    on<SubmitContactMessageEvent>(_onSubmitContact);
  }

  Future<void> _onFetchData(
    FetchPortfolioDataEvent event,
    Emitter<PortfolioState> emit,
  ) async {
    // Keep existing data visible and mark syncing
    if (state is PortfolioLoaded) {
      emit((state as PortfolioLoaded).copyWith(isSyncing: true));
    } else {
      emit(PortfolioLoaded.initial(isSyncing: true));
    }

    try {
      // Parallel execution of all 7 endpoints
      final results = await Future.wait([
        getProfileUseCase(),
        getProjectsUseCase(),
        getSkillsUseCase(),
        getExperiencesUseCase(),
        getSocialLinksUseCase(),
        getBooksUseCase(),
        getHighlightsUseCase(),
      ]);

      final profileRes = results[0] as Either<Failure, ProfileEntity>;
      final projectsRes = results[1] as Either<Failure, List<ProjectEntity>>;
      final skillsRes = results[2] as Either<Failure, List<SkillEntity>>;
      final experiencesRes = results[3] as Either<Failure, List<ExperienceEntity>>;
      final linksRes = results[4] as Either<Failure, List<SocialLinkEntity>>;
      final booksRes = results[5] as Either<Failure, List<BookEntity>>;
      final highlightsRes = results[6] as Either<Failure, List<HighlightEntity>>;

      final currentState = state is PortfolioLoaded
          ? (state as PortfolioLoaded)
          : PortfolioLoaded.initial();

      final profile = profileRes.fold((_) => currentState.profile, (p) => p);
      final allProjects =
          projectsRes.fold((_) => currentState.allProjects, (p) => p);
      final skills = skillsRes.fold((_) => currentState.skills, (s) => s);
      final experiences =
          experiencesRes.fold((_) => currentState.experiences, (e) => e);
      final socialLinks =
          linksRes.fold((_) => currentState.socialLinks, (l) => l);
      final books = booksRes.fold((_) => currentState.books, (b) => b);
      final highlights =
          highlightsRes.fold((_) => currentState.highlights, (h) => h);

      final filteredProjects = currentState.selectedCategory == 'All'
          ? allProjects
          : allProjects
              .where((p) => p.category.toLowerCase() ==
                  currentState.selectedCategory.toLowerCase())
              .toList();

      emit(
        PortfolioLoaded(
          profile: profile,
          allProjects: allProjects,
          filteredProjects: filteredProjects,
          skills: skills,
          experiences: experiences,
          socialLinks: socialLinks,
          books: books,
          highlights: highlights,
          selectedCategory: currentState.selectedCategory,
          contactStatus: currentState.contactStatus,
          contactFeedback: currentState.contactFeedback,
          isSyncing: false,
        ),
      );
    } catch (e) {
      // Fallback gracefully without breaking UI
      if (state is PortfolioLoaded) {
        emit((state as PortfolioLoaded).copyWith(isSyncing: false));
      } else {
        emit(PortfolioLoaded.initial(isSyncing: false));
      }
    }
  }

  void _onFilterProjects(
    FilterProjectsByCategoryEvent event,
    Emitter<PortfolioState> emit,
  ) {
    if (state is PortfolioLoaded) {
      final current = state as PortfolioLoaded;
      final filtered = event.category == 'All'
          ? current.allProjects
          : current.allProjects
              .where(
                (p) =>
                    p.category.toLowerCase() == event.category.toLowerCase(),
              )
              .toList();

      emit(
        current.copyWith(
          selectedCategory: event.category,
          filteredProjects: filtered,
        ),
      );
    }
  }

  Future<void> _onSubmitContact(
    SubmitContactMessageEvent event,
    Emitter<PortfolioState> emit,
  ) async {
    if (state is PortfolioLoaded) {
      final current = state as PortfolioLoaded;
      emit(
        current.copyWith(
          contactStatus: ContactSubmissionStatus.submitting,
          contactFeedback: null,
        ),
      );

      final result = await sendContactMessageUseCase(
        name: event.name,
        email: event.email,
        subject: event.subject,
        message: event.message,
      );

      result.fold(
        (failure) {
          emit(
            current.copyWith(
              contactStatus: ContactSubmissionStatus.failure,
              contactFeedback: failure.message,
            ),
          );
        },
        (successMsg) {
          emit(
            current.copyWith(
              contactStatus: ContactSubmissionStatus.success,
              contactFeedback: successMsg,
            ),
          );
        },
      );
    }
  }
}
