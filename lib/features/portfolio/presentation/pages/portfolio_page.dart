import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/about_section.dart';
import '../widgets/books_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/portfolio_skeleton.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _booksKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<PortfolioBloc>().add(const FetchPortfolioDataEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state is PortfolioLoading) {
            return const PortfolioSkeleton();
          }

          if (state is PortfolioError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.error,
                      size: 54,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load portfolio',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<PortfolioBloc>().add(
                          const FetchPortfolioDataEvent(forceRefresh: true),
                        );
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PortfolioLoaded) {
            return Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      // Top Navigation Bar
                      NavBar(
                        onAboutTap: () => _scrollToKey(_aboutKey),
                        onSkillsTap: () => _scrollToKey(_skillsKey),
                        onProjectsTap: () => _scrollToKey(_projectsKey),
                        onBooksTap: () => _scrollToKey(_booksKey),
                        onExperienceTap: () => _scrollToKey(_experienceKey),
                        onContactTap: () => _scrollToKey(_contactKey),
                        socialLinks: state.socialLinks,
                      ),

                      // Main Scrollable Body
                      Expanded(
                        child: SelectionArea(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Center(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 1280),
                                child: Column(
                                  children: [
                                    KeyedSubtree(
                                      key: _heroKey,
                                      child: HeroSection(
                                        profile: state.profile,
                                        socialLinks: state.socialLinks,
                                        onProjectsTap: () =>
                                            _scrollToKey(_projectsKey),
                                        onContactTap: () =>
                                            _scrollToKey(_contactKey),
                                      ),
                                    ),
                                    KeyedSubtree(
                                      key: _aboutKey,
                                      child: AboutSection(
                                        profile: state.profile,
                                        highlights: state.highlights,
                                      ),
                                    ),
                                    KeyedSubtree(
                                      key: _skillsKey,
                                      child: SkillsSection(skills: state.skills),
                                    ),
                                    KeyedSubtree(
                                      key: _projectsKey,
                                      child: ProjectsSection(
                                        projects: state.filteredProjects,
                                        selectedCategory:
                                            state.selectedCategory,
                                      ),
                                    ),
                                    KeyedSubtree(
                                      key: _booksKey,
                                      child: BooksSection(books: state.books),
                                    ),
                                    KeyedSubtree(
                                      key: _experienceKey,
                                      child: ExperienceSection(
                                        experiences: state.experiences,
                                      ),
                                    ),
                                    KeyedSubtree(
                                      key: _contactKey,
                                      child:
                                          ContactSection(profile: state.profile),
                                    ),
                                    FooterSection(
                                      profile: state.profile,
                                      socialLinks: state.socialLinks,
                                      onScrollToTop: _scrollToTop,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Subtle top edge indicator while syncing in background
                if (state.isSyncing)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 2.5,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
