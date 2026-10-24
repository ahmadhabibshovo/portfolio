import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book_entity.dart';
import '../../domain/entities/highlight_entity.dart';
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
  }) : super(PortfolioInitial()) {
    on<FetchPortfolioDataEvent>(_onFetchData);
    on<FilterProjectsByCategoryEvent>(_onFilterProjects);
    on<SubmitContactMessageEvent>(_onSubmitContact);
  }

  Future<void> _onFetchData(
    FetchPortfolioDataEvent event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(PortfolioLoading());

    final profileRes = await getProfileUseCase();
    final projectsRes = await getProjectsUseCase();
    final skillsRes = await getSkillsUseCase();
    final experiencesRes = await getExperiencesUseCase();
    final linksRes = await getSocialLinksUseCase();
    final booksRes = await getBooksUseCase();
    final highlightsRes = await getHighlightsUseCase();

    profileRes.fold((failure) => emit(PortfolioError(failure.message)), (
      profile,
    ) {
      projectsRes.fold((failure) => emit(PortfolioError(failure.message)), (
        projects,
      ) {
        skillsRes.fold((failure) => emit(PortfolioError(failure.message)), (
          skills,
        ) {
          experiencesRes.fold(
            (failure) => emit(PortfolioError(failure.message)),
            (experiences) {
              final socialLinks = linksRes.fold<List<SocialLinkEntity>>(
                (_) => [],
                (links) => links,
              );
              final books = booksRes.fold<List<BookEntity>>(
                (_) => [],
                (b) => b,
              );
              final highlights = highlightsRes.fold<List<HighlightEntity>>(
                (_) => [],
                (h) => h,
              );

              emit(
                PortfolioLoaded(
                  profile: profile,
                  allProjects: projects,
                  filteredProjects: projects,
                  skills: skills,
                  experiences: experiences,
                  socialLinks: socialLinks,
                  books: books,
                  highlights: highlights,
                  selectedCategory: 'All',
                ),
              );
            },
          );
        });
      });
    });
  }

  void _onFilterProjects(
    FilterProjectsByCategoryEvent event,
    Emitter<PortfolioState> emit,
  ) {
    if (state is PortfolioLoaded) {
      final currentState = state as PortfolioLoaded;
      final category = event.category;

      final filtered = category == 'All'
          ? currentState.allProjects
          : currentState.allProjects
                .where(
                  (p) => p.category.toLowerCase() == category.toLowerCase(),
                )
                .toList();

      emit(
        currentState.copyWith(
          selectedCategory: category,
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
      final currentState = state as PortfolioLoaded;

      emit(
        currentState.copyWith(
          contactStatus: ContactSubmissionStatus.submitting,
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
            currentState.copyWith(
              contactStatus: ContactSubmissionStatus.failure,
              contactFeedback: failure.message,
            ),
          );
        },
        (feedback) {
          emit(
            currentState.copyWith(
              contactStatus: ContactSubmissionStatus.success,
              contactFeedback: feedback,
            ),
          );
        },
      );
    }
  }
}
