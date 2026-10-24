import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.authRepository,
  }) : super(AuthInitialState()) {
    on<AppStartedEvent>(_onAppStarted);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<LogoutRequestedEvent>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(
    AppStartedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final hasToken = await authRepository.isAuthenticated();
    if (!hasToken) {
      emit(UnauthenticatedState());
      return;
    }

    final userResult = await getCurrentUserUseCase();
    userResult.fold(
      (failure) => emit(UnauthenticatedState()),
      (user) => emit(AuthenticatedState(user)),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final loginResult = await loginUseCase(
      email: event.email,
      password: event.password,
    );

    await loginResult.fold(
      (failure) async {
        emit(AuthFailureState(failure.message));
      },
      (tokens) async {
        final userResult = await getCurrentUserUseCase();
        userResult.fold(
          (failure) => emit(AuthFailureState(failure.message)),
          (user) => emit(AuthenticatedState(user)),
        );
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await logoutUseCase();
    emit(UnauthenticatedState());
  }
}
