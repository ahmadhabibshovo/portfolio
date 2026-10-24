import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/admin_usecases.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final UpdateProfileAdminUseCase updateProfileUseCase;
  final CreateProjectAdminUseCase createProjectUseCase;
  final UpdateProjectAdminUseCase updateProjectUseCase;
  final DeleteProjectAdminUseCase deleteProjectUseCase;
  final CreateSkillAdminUseCase createSkillUseCase;
  final UpdateSkillAdminUseCase updateSkillUseCase;
  final DeleteSkillAdminUseCase deleteSkillUseCase;
  final CreateExperienceAdminUseCase createExperienceUseCase;
  final UpdateExperienceAdminUseCase updateExperienceUseCase;
  final DeleteExperienceAdminUseCase deleteExperienceUseCase;
  final GetAdminMessagesUseCase getAdminMessagesUseCase;
  final MarkAdminMessageReadUseCase markAdminMessageReadUseCase;
  final DeleteAdminMessageUseCase deleteAdminMessageUseCase;
  final UploadFileUseCase uploadFileUseCase;

  // Social Links Use Cases
  final GetAdminSocialLinksUseCase getSocialLinksUseCase;
  final CreateSocialLinkUseCase createSocialLinkUseCase;
  final UpdateSocialLinkUseCase updateSocialLinkUseCase;
  final DeleteSocialLinkUseCase deleteSocialLinkUseCase;

  // Books Use Cases
  final GetAdminBooksUseCase getBooksUseCase;
  final CreateBookUseCase createBookUseCase;
  final UpdateBookUseCase updateBookUseCase;
  final DeleteBookUseCase deleteBookUseCase;

  // Highlights Use Cases
  final GetAdminHighlightsUseCase getHighlightsUseCase;
  final CreateHighlightUseCase createHighlightUseCase;
  final UpdateHighlightUseCase updateHighlightUseCase;
  final DeleteHighlightUseCase deleteHighlightUseCase;

  AdminBloc({
    required this.updateProfileUseCase,
    required this.createProjectUseCase,
    required this.updateProjectUseCase,
    required this.deleteProjectUseCase,
    required this.createSkillUseCase,
    required this.updateSkillUseCase,
    required this.deleteSkillUseCase,
    required this.createExperienceUseCase,
    required this.updateExperienceUseCase,
    required this.deleteExperienceUseCase,
    required this.getAdminMessagesUseCase,
    required this.markAdminMessageReadUseCase,
    required this.deleteAdminMessageUseCase,
    required this.uploadFileUseCase,
    required this.getSocialLinksUseCase,
    required this.createSocialLinkUseCase,
    required this.updateSocialLinkUseCase,
    required this.deleteSocialLinkUseCase,
    required this.getBooksUseCase,
    required this.createBookUseCase,
    required this.updateBookUseCase,
    required this.deleteBookUseCase,
    required this.getHighlightsUseCase,
    required this.createHighlightUseCase,
    required this.updateHighlightUseCase,
    required this.deleteHighlightUseCase,
  }) : super(AdminInitialState()) {
    on<LoadAdminDataEvent>(_onLoadData);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<CreateProjectEvent>(_onCreateProject);
    on<UpdateProjectEvent>(_onUpdateProject);
    on<DeleteProjectEvent>(_onDeleteProject);
    on<CreateSkillEvent>(_onCreateSkill);
    on<UpdateSkillEvent>(_onUpdateSkill);
    on<DeleteSkillEvent>(_onDeleteSkill);
    on<CreateExperienceEvent>(_onCreateExperience);
    on<UpdateExperienceEvent>(_onUpdateExperience);
    on<DeleteExperienceEvent>(_onDeleteExperience);
    on<LoadAdminMessagesEvent>(_onLoadMessages);
    on<MarkMessageReadEvent>(_onMarkMessageRead);
    on<DeleteMessageEvent>(_onDeleteMessage);
    on<UploadFileEvent>(_onUploadFile);

    // Social Links
    on<CreateSocialLinkEvent>(_onCreateSocialLink);
    on<UpdateSocialLinkEvent>(_onUpdateSocialLink);
    on<DeleteSocialLinkEvent>(_onDeleteSocialLink);

    // Books
    on<CreateBookEvent>(_onCreateBook);
    on<UpdateBookEvent>(_onUpdateBook);
    on<DeleteBookEvent>(_onDeleteBook);

    // Highlights
    on<CreateHighlightEvent>(_onCreateHighlight);
    on<UpdateHighlightEvent>(_onUpdateHighlight);
    on<DeleteHighlightEvent>(_onDeleteHighlight);
  }

  Future<void> _onLoadData(
    LoadAdminDataEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoadingState());

    final msgRes = await getAdminMessagesUseCase();
    final linksRes = await getSocialLinksUseCase();
    final booksRes = await getBooksUseCase();
    final highlightsRes = await getHighlightsUseCase();

    msgRes.fold((failure) => emit(AdminFailureState(failure.message)), (
      messages,
    ) {
      final links = linksRes.fold((_) => [], (l) => l);
      final books = booksRes.fold((_) => [], (b) => b);
      final highlights = highlightsRes.fold((_) => [], (h) => h);

      emit(
        AdminLoadedState(
          messages: messages,
          socialLinks: links.cast(),
          books: books.cast(),
          highlights: highlights.cast(),
        ),
      );
    });
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateProfileUseCase(event.profile);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Profile updated successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onCreateProject(
    CreateProjectEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await createProjectUseCase(event.project);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Project created successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onUpdateProject(
    UpdateProjectEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateProjectUseCase(event.project);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Project updated successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onDeleteProject(
    DeleteProjectEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteProjectUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Project deleted successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onCreateSkill(
    CreateSkillEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await createSkillUseCase(event.skill);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Skill created successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onUpdateSkill(
    UpdateSkillEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateSkillUseCase(event.skill);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Skill updated successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onDeleteSkill(
    DeleteSkillEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteSkillUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Skill deleted successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onCreateExperience(
    CreateExperienceEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await createExperienceUseCase(event.experience);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Experience created successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onUpdateExperience(
    UpdateExperienceEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateExperienceUseCase(event.experience);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Experience updated successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onDeleteExperience(
    DeleteExperienceEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteExperienceUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            feedbackMessage: 'Experience deleted successfully!',
          ),
        );
      }
    });
  }

  Future<void> _onLoadMessages(
    LoadAdminMessagesEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await getAdminMessagesUseCase(unreadOnly: event.unreadOnly);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (messages) {
      if (state is AdminLoadedState) {
        emit((state as AdminLoadedState).copyWith(messages: messages));
      } else {
        emit(AdminLoadedState(messages: messages));
      }
    });
  }

  Future<void> _onMarkMessageRead(
    MarkMessageReadEvent event,
    Emitter<AdminState> emit,
  ) async {
    await markAdminMessageReadUseCase(event.id, event.isRead);
    add(const LoadAdminMessagesEvent());
  }

  Future<void> _onDeleteMessage(
    DeleteMessageEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteAdminMessageUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(const LoadAdminMessagesEvent());
    });
  }

  // Social Link Handlers
  Future<void> _onCreateSocialLink(
    CreateSocialLinkEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await createSocialLinkUseCase(event.link);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onUpdateSocialLink(
    UpdateSocialLinkEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateSocialLinkUseCase(event.link);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onDeleteSocialLink(
    DeleteSocialLinkEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteSocialLinkUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  // Book Handlers
  Future<void> _onCreateBook(
    CreateBookEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await createBookUseCase(event.book);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onUpdateBook(
    UpdateBookEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateBookUseCase(event.book);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onDeleteBook(
    DeleteBookEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteBookUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  // Highlight Handlers
  Future<void> _onCreateHighlight(
    CreateHighlightEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await createHighlightUseCase(event.highlight);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onUpdateHighlight(
    UpdateHighlightEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await updateHighlightUseCase(event.highlight);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onDeleteHighlight(
    DeleteHighlightEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await deleteHighlightUseCase(event.id);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (_) {
      add(LoadAdminDataEvent());
    });
  }

  Future<void> _onUploadFile(
    UploadFileEvent event,
    Emitter<AdminState> emit,
  ) async {
    final res = await uploadFileUseCase(event.fileBytes, event.fileName);
    res.fold((failure) => emit(AdminFailureState(failure.message)), (url) {
      if (state is AdminLoadedState) {
        emit(
          (state as AdminLoadedState).copyWith(
            uploadedFileUrl: url,
            feedbackMessage: 'File uploaded successfully!',
          ),
        );
      }
    });
  }
}
