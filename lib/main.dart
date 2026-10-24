import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/admin/presentation/bloc/admin_bloc.dart';
import 'features/admin/presentation/pages/admin_dashboard_page.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioBloc>(create: (_) => di.sl<PortfolioBloc>()),
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(AppStartedEvent()),
        ),
        BlocProvider<AdminBloc>(create: (_) => di.sl<AdminBloc>()),
      ],
      child: MaterialApp(
        title: 'Ahmad Habib | Mobile App Developer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const PortfolioPage(),
          '/admin': (context) => const AdminGuardPage(),
        },
      ),
    );
  }
}

class AdminGuardPage extends StatelessWidget {
  const AdminGuardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return AdminDashboardPage(
            onLogout: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          );
        }

        return LoginPage(
          onLoginSuccess: () {
            // State automatically transitions to AuthenticatedState
          },
        );
      },
    );
  }
}
