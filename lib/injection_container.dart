import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'core/network/token_manager.dart';
import 'features/admin/data/datasources/admin_remote_data_source.dart';
import 'features/admin/data/repositories/admin_repository_impl.dart';
import 'features/admin/domain/repositories/admin_repository.dart';
import 'features/admin/domain/usecases/admin_usecases.dart';
import 'features/admin/presentation/bloc/admin_bloc.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/repositories/portfolio_repository.dart';
import 'features/portfolio/domain/usecases/get_books_usecase.dart';
import 'features/portfolio/domain/usecases/get_experiences_usecase.dart';
import 'features/portfolio/domain/usecases/get_highlights_usecase.dart';
import 'features/portfolio/domain/usecases/get_profile_usecase.dart';
import 'features/portfolio/domain/usecases/get_project_detail_usecase.dart';
import 'features/portfolio/domain/usecases/get_projects_usecase.dart';
import 'features/portfolio/domain/usecases/get_skills_usecase.dart';
import 'features/portfolio/domain/usecases/get_social_links_usecase.dart';
import 'features/portfolio/domain/usecases/send_contact_message_usecase.dart';
import 'features/portfolio/presentation/bloc/portfolio_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 1. External & Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<TokenManager>(() => TokenManagerImpl(prefs: sl()));

  sl.registerLazySingleton<ApiClient>(() => ApiClient(tokenManager: sl()));

  // 2. Portfolio Feature
  // BLoC
  sl.registerFactory(
    () => PortfolioBloc(
      getProfileUseCase: sl(),
      getProjectsUseCase: sl(),
      getSkillsUseCase: sl(),
      getExperiencesUseCase: sl(),
      getSocialLinksUseCase: sl(),
      getBooksUseCase: sl(),
      getHighlightsUseCase: sl(),
      sendContactMessageUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectDetailUseCase(sl()));
  sl.registerLazySingleton(() => GetSkillsUseCase(sl()));
  sl.registerLazySingleton(() => GetExperiencesUseCase(sl()));
  sl.registerLazySingleton(() => GetSocialLinksUseCase(sl()));
  sl.registerLazySingleton(() => GetBooksUseCase(sl()));
  sl.registerLazySingleton(() => GetHighlightsUseCase(sl()));
  sl.registerLazySingleton(() => SendContactMessageUseCase(sl()));
  // Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(remoteDataSource: sl()),
  );
  // Data source
  sl.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(client: sl()),
  );

  // 3. Auth Feature
  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      authRepository: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), tokenManager: sl()),
  );
  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // 4. Admin Feature
  // BLoC
  sl.registerFactory(
    () => AdminBloc(
      updateProfileUseCase: sl(),
      createProjectUseCase: sl(),
      updateProjectUseCase: sl(),
      deleteProjectUseCase: sl(),
      createSkillUseCase: sl(),
      updateSkillUseCase: sl(),
      deleteSkillUseCase: sl(),
      createExperienceUseCase: sl(),
      updateExperienceUseCase: sl(),
      deleteExperienceUseCase: sl(),
      getAdminMessagesUseCase: sl(),
      markAdminMessageReadUseCase: sl(),
      deleteAdminMessageUseCase: sl(),
      uploadFileUseCase: sl(),
      getSocialLinksUseCase: sl(),
      createSocialLinkUseCase: sl(),
      updateSocialLinkUseCase: sl(),
      deleteSocialLinkUseCase: sl(),
      getBooksUseCase: sl(),
      createBookUseCase: sl(),
      updateBookUseCase: sl(),
      deleteBookUseCase: sl(),
      getHighlightsUseCase: sl(),
      createHighlightUseCase: sl(),
      updateHighlightUseCase: sl(),
      deleteHighlightUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => UpdateProfileAdminUseCase(sl()));
  sl.registerLazySingleton(() => CreateProjectAdminUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProjectAdminUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProjectAdminUseCase(sl()));
  sl.registerLazySingleton(() => CreateSkillAdminUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSkillAdminUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSkillAdminUseCase(sl()));
  sl.registerLazySingleton(() => CreateExperienceAdminUseCase(sl()));
  sl.registerLazySingleton(() => UpdateExperienceAdminUseCase(sl()));
  sl.registerLazySingleton(() => DeleteExperienceAdminUseCase(sl()));
  sl.registerLazySingleton(() => GetAdminMessagesUseCase(sl()));
  sl.registerLazySingleton(() => MarkAdminMessageReadUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAdminMessageUseCase(sl()));
  sl.registerLazySingleton(() => UploadFileUseCase(sl()));

  sl.registerLazySingleton(() => GetAdminSocialLinksUseCase(sl()));
  sl.registerLazySingleton(() => CreateSocialLinkUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSocialLinkUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSocialLinkUseCase(sl()));

  sl.registerLazySingleton(() => GetAdminBooksUseCase(sl()));
  sl.registerLazySingleton(() => CreateBookUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBookUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBookUseCase(sl()));

  sl.registerLazySingleton(() => GetAdminHighlightsUseCase(sl()));
  sl.registerLazySingleton(() => CreateHighlightUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHighlightUseCase(sl()));
  sl.registerLazySingleton(() => DeleteHighlightUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(remoteDataSource: sl()),
  );
  // Data source
  sl.registerLazySingleton<AdminRemoteDataSource>(
    () => AdminRemoteDataSourceImpl(client: sl()),
  );
}
