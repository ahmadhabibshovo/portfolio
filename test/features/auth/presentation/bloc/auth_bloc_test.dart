import 'package:flutter_test/flutter_test.dart';
import 'package:ahmadhabibshovo/core/error/failures.dart';
import 'package:ahmadhabibshovo/core/utils/either.dart';
import 'package:ahmadhabibshovo/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:ahmadhabibshovo/features/auth/domain/entities/user_entity.dart';
import 'package:ahmadhabibshovo/features/auth/domain/repositories/auth_repository.dart';
import 'package:ahmadhabibshovo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:ahmadhabibshovo/features/auth/domain/usecases/login_usecase.dart';
import 'package:ahmadhabibshovo/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ahmadhabibshovo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ahmadhabibshovo/features/auth/presentation/bloc/auth_event.dart';
import 'package:ahmadhabibshovo/features/auth/presentation/bloc/auth_state.dart';

class FakeAuthRepository implements AuthRepository {
  bool isAuth = false;
  bool shouldFail = false;

  final testUser = const UserEntity(
    id: 1,
    email: 'admin@example.com',
    firstName: 'Admin',
    lastName: 'User',
    phone: '+8801700000000',
    role: 'admin',
    isActive: true,
  );

  final testTokens = const AuthTokensEntity(
    accessToken: 'mock_access_token',
    refreshToken: 'mock_refresh_token',
  );

  @override
  Future<Either<Failure, AuthTokensEntity>> login({
    required String email,
    required String password,
  }) async {
    if (shouldFail) {
      return const Left(ServerFailure('Invalid email or password'));
    }
    isAuth = true;
    return Right(testTokens);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    isAuth = false;
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    if (shouldFail) {
      return const Left(ServerFailure('Failed to fetch user'));
    }
    return Right(testUser);
  }

  @override
  Future<bool> isAuthenticated() async {
    return isAuth;
  }
}

void main() {
  late FakeAuthRepository authRepository;
  late AuthBloc authBloc;

  setUp(() {
    authRepository = FakeAuthRepository();
    authBloc = AuthBloc(
      loginUseCase: LoginUseCase(authRepository),
      logoutUseCase: LogoutUseCase(authRepository),
      getCurrentUserUseCase: GetCurrentUserUseCase(authRepository),
      authRepository: authRepository,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  test('Initial state should be AuthInitialState', () {
    expect(authBloc.state, equals(AuthInitialState()));
  });

  test(
    'AppStartedEvent emits UnauthenticatedState when not authenticated',
    () async {
      authRepository.isAuth = false;

      expectLater(authBloc.stream, emitsInOrder([isA<UnauthenticatedState>()]));

      authBloc.add(AppStartedEvent());
    },
  );

  test(
    'AppStartedEvent emits AuthenticatedState when user is authenticated',
    () async {
      authRepository.isAuth = true;

      expectLater(authBloc.stream, emitsInOrder([isA<AuthenticatedState>()]));

      authBloc.add(AppStartedEvent());
    },
  );

  test('LoginSubmittedEvent emits AuthLoadingState and AuthenticatedState on success', () async {
    expectLater(
      authBloc.stream,
      emitsInOrder([isA<AuthLoadingState>(), isA<AuthenticatedState>()]),
    );

    authBloc.add(
      const LoginSubmittedEvent(
        email: 'admin@example.com',
        password: 'TestPassword123!',
      ),
    );
  });

  test('LoginSubmittedEvent emits AuthFailureState on failure', () async {
    authRepository.shouldFail = true;

    expectLater(
      authBloc.stream,
      emitsInOrder([isA<AuthLoadingState>(), isA<AuthFailureState>()]),
    );

    authBloc.add(
      const LoginSubmittedEvent(
        email: 'wrong@example.com',
        password: 'wrongpassword',
      ),
    );
  });

  test(
    'LogoutRequestedEvent emits AuthLoadingState then UnauthenticatedState',
    () async {
      expectLater(
        authBloc.stream,
        emitsInOrder([isA<AuthLoadingState>(), isA<UnauthenticatedState>()]),
      );

      authBloc.add(LogoutRequestedEvent());
    },
  );
}
