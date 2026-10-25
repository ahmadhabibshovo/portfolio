import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../injection_container.dart';
import '../../../../core/utils/icon_resolver.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../portfolio/domain/entities/book_entity.dart';
import '../../../portfolio/domain/entities/experience_entity.dart';
import '../../../portfolio/domain/entities/highlight_entity.dart';
import '../../../portfolio/domain/entities/profile_entity.dart';
import '../../../portfolio/domain/entities/project_entity.dart';
import '../../../portfolio/domain/entities/skill_entity.dart';
import '../../../portfolio/domain/entities/social_link_entity.dart';
import '../../../portfolio/presentation/bloc/portfolio_bloc.dart';
import '../../../portfolio/presentation/bloc/portfolio_event.dart';
import '../../../portfolio/presentation/bloc/portfolio_state.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';

class AdminDashboardPage extends StatefulWidget {
  final VoidCallback onLogout;

  const AdminDashboardPage({super.key, required this.onLogout});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    context.read<AdminBloc>().add(LoadAdminDataEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is AdminLoadedState && state.feedbackMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text(state.feedbackMessage!),
            ),
          );
          // Refresh main public portfolio data in sync!
          context.read<PortfolioBloc>().add(const FetchPortfolioDataEvent());
        } else if (state is AdminFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Row(
            children: [
              Icon(Icons.dashboard_rounded, color: AppColors.primary, size: 22),
              SizedBox(width: 10),
              Text(
                'Ahmad Habib | Portfolio Control Center',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 14),
              ),
              icon: const Icon(Icons.open_in_browser_rounded, size: 18),
              label: const Text(
                'View Public Site',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            const SizedBox(width: 6),
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Refresh Data',
              onPressed: () {
                context.read<AdminBloc>().add(LoadAdminDataEvent());
                context.read<PortfolioBloc>().add(
                  const FetchPortfolioDataEvent(),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.lock_reset_rounded, color: AppColors.primary),
              tooltip: 'Change Password',
              onPressed: () => _showChangePasswordDialog(context),
            ),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppColors.error),
              tooltip: 'Logout',
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequestedEvent());
                widget.onLogout();
              },
            ),
            const SizedBox(width: 8),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: const [
              Tab(
                icon: Icon(Icons.mark_email_unread_outlined),
                text: 'Inquiries',
              ),
              Tab(icon: Icon(Icons.person_outline), text: 'Profile & Status'),
              Tab(icon: Icon(Icons.share_rounded), text: 'Social & Links'),
              Tab(icon: Icon(Icons.code_rounded), text: 'Projects'),
              Tab(icon: Icon(Icons.build_outlined), text: 'Skills'),
              Tab(
                icon: Icon(Icons.menu_book_rounded),
                text: 'Books & Learning',
              ),
              Tab(icon: Icon(Icons.timeline_rounded), text: 'Experience'),
              Tab(icon: Icon(Icons.auto_awesome_rounded), text: 'Highlights'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildInquiriesTab(),
            _buildProfileTab(),
            _buildSocialLinksTab(),
            _buildProjectsTab(),
            _buildSkillsTab(),
            _buildBooksTab(),
            _buildExperiencesTab(),
            _buildHighlightsTab(),
          ],
        ),
      ),
    );
  }

  // 1. Inquiries Tab
  Widget _buildInquiriesTab() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminLoadedState) {
          final messages = state.messages;
          if (messages.isEmpty) {
            return const Center(
              child: Text(
                'No inquiries received yet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: messages.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final msg = messages[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: msg.isRead
                        ? AppColors.surfaceLight
                        : AppColors.primary.withValues(alpha: 0.2),
                    child: Icon(
                      msg.isRead
                          ? Icons.drafts_outlined
                          : Icons.mark_email_unread_rounded,
                      color: msg.isRead
                          ? AppColors.textMuted
                          : AppColors.primary,
                    ),
                  ),
                  title: Text(
                    '${msg.name} (${msg.email})',
                    style: TextStyle(
                      fontWeight: msg.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (msg.subject.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Subject: ${msg.subject}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      const SizedBox(height: 6),
                      Text(
                        msg.message,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          msg.isRead
                              ? Icons.mark_email_unread_outlined
                              : Icons.mark_email_read_outlined,
                          color: AppColors.primary,
                        ),
                        tooltip: msg.isRead ? 'Mark Unread' : 'Mark Read',
                        onPressed: () {
                          context.read<AdminBloc>().add(
                            MarkMessageReadEvent(msg.id, !msg.isRead),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        tooltip: 'Delete Message',
                        onPressed: () {
                          context.read<AdminBloc>().add(
                            DeleteMessageEvent(msg.id),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // 2. Profile & Availability Tab
  Widget _buildProfileTab() {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final p = state.profile;
          final nameCtl = TextEditingController(text: p.name);
          final headlineCtl = TextEditingController(text: p.headline);
          final bioCtl = TextEditingController(text: p.bio);
          final emailCtl = TextEditingController(text: p.email);
          final phoneCtl = TextEditingController(text: p.phone);
          final locationCtl = TextEditingController(text: p.location);
          final websiteCtl = TextEditingController(text: p.website);
          final avatarUrlCtl = TextEditingController(text: p.avatarUrl);
          final cvUrlCtl = TextEditingController(text: p.cvUrl);
          final availStatusCtl = TextEditingController(
            text: p.availabilityStatus,
          );
          bool isAvailable = p.isAvailable;

          return StatefulBuilder(
            builder: (ctx, setProfileState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Profile & Dynamic Availability Control',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Update your public information, availability status, resume, and contact links.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Availability Controls Card
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.cardBorder),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.radar_rounded,
                                            color: AppColors.accent,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Availability Badge',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Switch(
                                        value: isAvailable,
                                        activeThumbColor: AppColors.accent,
                                        onChanged: (val) {
                                          setProfileState(() {
                                            isAvailable = val;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: availStatusCtl,
                                    decoration: const InputDecoration(
                                      labelText:
                                          'Availability Tagline / Status Text',
                                      hintText: 'e.g. Available for Mobile App Development',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            TextField(
                              controller: nameCtl,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: headlineCtl,
                              decoration: const InputDecoration(
                                labelText: 'Professional Headline',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: bioCtl,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'Bio / About Me Summary',
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: emailCtl,
                                    decoration: const InputDecoration(
                                      labelText: 'Contact Email',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: phoneCtl,
                                    decoration: const InputDecoration(
                                      labelText: 'Phone Number',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: locationCtl,
                                    decoration: const InputDecoration(
                                      labelText: 'Location (City, Country)',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: websiteCtl,
                                    decoration: const InputDecoration(
                                      labelText: 'Personal Website URL',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: avatarUrlCtl,
                              decoration: const InputDecoration(
                                labelText: 'Avatar Image URL',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: cvUrlCtl,
                              decoration: const InputDecoration(
                                labelText: 'CV / Resume Download URL',
                              ),
                            ),
                            const SizedBox(height: 28),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final updated = ProfileEntity(
                                    id: p.id,
                                    name: nameCtl.text.trim(),
                                    headline: headlineCtl.text.trim(),
                                    bio: bioCtl.text.trim(),
                                    email: emailCtl.text.trim(),
                                    phone: phoneCtl.text.trim(),
                                    location: locationCtl.text.trim(),
                                    avatarUrl: avatarUrlCtl.text.trim(),
                                    cvUrl: cvUrlCtl.text.trim(),
                                    github: p.github,
                                    linkedin: p.linkedin,
                                    facebook: p.facebook,
                                    leetcode: p.leetcode,
                                    hackerearth: p.hackerearth,
                                    website: websiteCtl.text.trim(),
                                    isAvailable: isAvailable,
                                    availabilityStatus: availStatusCtl.text
                                        .trim(),
                                  );
                                  context.read<AdminBloc>().add(
                                    UpdateProfileEvent(updated),
                                  );
                                },
                                child: const Text(
                                  'Save Profile & Availability Changes',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // 3. Social & Platform Links Tab
  Widget _buildSocialLinksTab() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminLoadedState) {
          final links = state.socialLinks;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddSocialLinkDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Platform Link'),
            ),
            body: links.isEmpty
                ? const Center(
                    child: Text(
                      'No social links added yet.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: links.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final link = links[index];
                      return Card(
                        child: ListTile(
                          leading: Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AppIconResolver.getIcon(
                              link.icon,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(
                                link.platform,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: link.isActive
                                      ? AppColors.success.withValues(
                                          alpha: 0.15,
                                        )
                                      : AppColors.error.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  link.isActive ? 'ACTIVE' : 'HIDDEN',
                                  style: TextStyle(
                                    color: link.isActive
                                        ? AppColors.success
                                        : AppColors.error,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            link.url,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                                tooltip: 'Edit Link',
                                onPressed: () =>
                                    _showEditSocialLinkDialog(context, link),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.error,
                                  size: 18,
                                ),
                                tooltip: 'Delete Link',
                                onPressed: () {
                                  context.read<AdminBloc>().add(
                                    DeleteSocialLinkEvent(link.id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // 4. Projects Tab
  Widget _buildProjectsTab() {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final projects = state.allProjects;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddProjectDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Project'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: projects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final p = projects[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.15,
                      ),
                      child: Text(
                        '#${p.id}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      p.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Category: ${p.category} | ${p.techStack}',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.error,
                          ),
                          tooltip: 'Delete Project',
                          onPressed: () {
                            context.read<AdminBloc>().add(
                              DeleteProjectEvent(p.id),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // 5. Skills Tab
  Widget _buildSkillsTab() {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final skills = state.skills;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddSkillDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Skill'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: skills.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final s = skills[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary.withValues(
                        alpha: 0.15,
                      ),
                      child: Text(
                        '${s.proficiency}%',
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      s.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Category: ${s.category}'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.error,
                      ),
                      tooltip: 'Delete Skill',
                      onPressed: () {
                        context.read<AdminBloc>().add(DeleteSkillEvent(s.id));
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // 6. Books & Learning Tab
  Widget _buildBooksTab() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminLoadedState) {
          final books = state.books;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddBookDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Book'),
            ),
            body: books.isEmpty
                ? const Center(
                    child: Text(
                      'No books added yet.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: books.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final b = books[index];
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.surfaceLight,
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: AppColors.primary,
                            ),
                          ),
                          title: Text(
                            b.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'by ${b.author} | Status: ${b.status} | Rating: ${b.rating}ÃƒÂ¢Ã‹Å“Ã¢â‚¬Â¦',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.error,
                                ),
                                tooltip: 'Delete Book',
                                onPressed: () {
                                  context.read<AdminBloc>().add(
                                    DeleteBookEvent(b.id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // 7. Experiences Tab
  Widget _buildExperiencesTab() {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final exps = state.experiences;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddExperienceDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Experience'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: exps.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final e = exps[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.accent.withValues(alpha: 0.15),
                      child: const Icon(
                        Icons.work_outline_rounded,
                        color: AppColors.accent,
                      ),
                    ),
                    title: Text(
                      '${e.role} @ ${e.company}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${e.startDate} - ${e.endDate} (${e.location})',
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.error,
                      ),
                      tooltip: 'Delete Experience',
                      onPressed: () {
                        context.read<AdminBloc>().add(
                          DeleteExperienceEvent(e.id),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // 8. Highlights Tab
  Widget _buildHighlightsTab() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminLoadedState) {
          final highlights = state.highlights;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddHighlightDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Highlight'),
            ),
            body: highlights.isEmpty
                ? const Center(
                    child: Text(
                      'No highlights added yet.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: highlights.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final h = highlights[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.surfaceLight,
                            child: Icon(
                              AppIconResolver.getMaterialIcon(h.icon),
                              color: AppColors.primary,
                            ),
                          ),
                          title: Text(
                            h.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(h.description),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.error,
                            ),
                            tooltip: 'Delete Highlight',
                            onPressed: () {
                              context.read<AdminBloc>().add(
                                DeleteHighlightEvent(h.id),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // Dialogs
  void _showAddSocialLinkDialog(BuildContext context) {
    final platformCtl = TextEditingController();
    final urlCtl = TextEditingController();
    String selectedIcon = 'github';
    bool isActive = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Text('Add Social & Platform Link'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: platformCtl,
                  decoration: const InputDecoration(
                    labelText: 'Platform (e.g. HackerRank, Book, GitHub)',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: urlCtl,
                  decoration: const InputDecoration(
                    labelText: 'Profile / Resource URL',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedIcon,
                  decoration: const InputDecoration(labelText: 'Select Icon'),
                  items: AppIconResolver.availableIcons.map((opt) {
                    return DropdownMenuItem<String>(
                      value: opt.key,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: AppIconResolver.getIcon(
                              opt.key,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(opt.label),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setDlgState(() => selectedIcon = val);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (val) =>
                          setDlgState(() => isActive = val ?? true),
                    ),
                    const Text('Show publicly on portfolio'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final link = SocialLinkEntity(
                  id: 0,
                  platform: platformCtl.text.trim(),
                  url: urlCtl.text.trim(),
                  icon: selectedIcon,
                  isActive: isActive,
                );
                context.read<AdminBloc>().add(CreateSocialLinkEvent(link));
                Navigator.pop(ctx);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditSocialLinkDialog(BuildContext context, SocialLinkEntity link) {
    final platformCtl = TextEditingController(text: link.platform);
    final urlCtl = TextEditingController(text: link.url);
    String selectedIcon = link.icon;
    bool isActive = link.isActive;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: Text('Edit ${link.platform} Link'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: platformCtl,
                  decoration: const InputDecoration(labelText: 'Platform'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: urlCtl,
                  decoration: const InputDecoration(labelText: 'URL'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedIcon,
                  decoration: const InputDecoration(labelText: 'Select Icon'),
                  items: AppIconResolver.availableIcons.map((opt) {
                    return DropdownMenuItem<String>(
                      value: opt.key,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: AppIconResolver.getIcon(
                              opt.key,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(opt.label),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setDlgState(() => selectedIcon = val);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (val) =>
                          setDlgState(() => isActive = val ?? true),
                    ),
                    const Text('Show publicly on portfolio'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updated = SocialLinkEntity(
                  id: link.id,
                  platform: platformCtl.text.trim(),
                  url: urlCtl.text.trim(),
                  icon: selectedIcon,
                  isActive: isActive,
                );
                context.read<AdminBloc>().add(UpdateSocialLinkEvent(updated));
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBookDialog(BuildContext context) {
    final titleCtl = TextEditingController();
    final authorCtl = TextEditingController();
    final coverCtl = TextEditingController();
    final linkCtl = TextEditingController();
    final reviewCtl = TextEditingController();
    String status = 'Currently Reading';
    int rating = 5;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Text('Add Book to Reading List'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtl,
                  decoration: const InputDecoration(labelText: 'Book Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: authorCtl,
                  decoration: const InputDecoration(labelText: 'Author'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: coverCtl,
                  decoration: const InputDecoration(
                    labelText: 'Cover Image URL',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: linkCtl,
                  decoration: const InputDecoration(
                    labelText: 'Goodreads / Purchase Link',
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(
                    labelText: 'Reading Status',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Currently Reading',
                      child: Text('Currently Reading'),
                    ),
                    DropdownMenuItem(
                      value: 'Recommended',
                      child: Text('Recommended'),
                    ),
                    DropdownMenuItem(
                      value: 'Completed',
                      child: Text('Completed'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setDlgState(() => status = val);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  initialValue: rating,
                  decoration: const InputDecoration(
                    labelText: 'Rating (Stars)',
                  ),
                  items: List.generate(5, (i) => i + 1).map((r) {
                    return DropdownMenuItem(value: r, child: Text('$r Stars'));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setDlgState(() => rating = val);
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: reviewCtl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Takeaway / Brief Review',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final book = BookEntity(
                  id: 0,
                  title: titleCtl.text.trim(),
                  author: authorCtl.text.trim(),
                  coverUrl: coverCtl.text.trim(),
                  linkUrl: linkCtl.text.trim(),
                  status: status,
                  rating: rating,
                  review: reviewCtl.text.trim(),
                );
                context.read<AdminBloc>().add(CreateBookEvent(book));
                Navigator.pop(ctx);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddHighlightDialog(BuildContext context) {
    final titleCtl = TextEditingController();
    final descCtl = TextEditingController();
    String icon = 'architecture';
    String colorTag = 'primary';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Text('Add About Highlight Card'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtl,
                  decoration: const InputDecoration(
                    labelText: 'Highlight Title',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descCtl,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: icon,
                  decoration: const InputDecoration(labelText: 'Icon'),
                  items: const [
                    DropdownMenuItem(
                      value: 'architecture',
                      child: Text('Architecture'),
                    ),
                    DropdownMenuItem(
                      value: 'speed',
                      child: Text('Performance / Speed'),
                    ),
                    DropdownMenuItem(
                      value: 'cloud',
                      child: Text('Cloud / Fullstack'),
                    ),
                    DropdownMenuItem(value: 'mobile', child: Text('Mobile')),
                    DropdownMenuItem(
                      value: 'database',
                      child: Text('Database'),
                    ),
                    DropdownMenuItem(
                      value: 'security',
                      child: Text('Security'),
                    ),
                    DropdownMenuItem(
                      value: 'terminal',
                      child: Text('Terminal / CLI'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setDlgState(() => icon = val);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: colorTag,
                  decoration: const InputDecoration(labelText: 'Color Accent'),
                  items: const [
                    DropdownMenuItem(
                      value: 'primary',
                      child: Text('Cyan / Primary'),
                    ),
                    DropdownMenuItem(
                      value: 'secondary',
                      child: Text('Purple / Secondary'),
                    ),
                    DropdownMenuItem(
                      value: 'accent',
                      child: Text('Emerald / Accent'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setDlgState(() => colorTag = val);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final h = HighlightEntity(
                  id: 0,
                  title: titleCtl.text.trim(),
                  description: descCtl.text.trim(),
                  icon: icon,
                  colorTag: colorTag,
                );
                context.read<AdminBloc>().add(CreateHighlightEvent(h));
                Navigator.pop(ctx);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    final titleCtl = TextEditingController();
    final descCtl = TextEditingController();
    final techCtl = TextEditingController();
    final categoryCtl = TextEditingController(text: 'Mobile');
    final githubCtl = TextEditingController();
    final liveCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Project'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtl,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descCtl,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: techCtl,
                decoration: const InputDecoration(
                  labelText: 'Tech Stack (comma separated)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: categoryCtl,
                decoration: const InputDecoration(
                  labelText: 'Category (Mobile, Web, AI)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: githubCtl,
                decoration: const InputDecoration(labelText: 'GitHub URL'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: liveCtl,
                decoration: const InputDecoration(labelText: 'Live Demo URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newProject = ProjectEntity(
                id: 0,
                title: titleCtl.text.trim(),
                slug: '',
                description: descCtl.text.trim(),
                shortDescription: descCtl.text.trim(),
                techStack: techCtl.text.trim(),
                imageUrl: '',
                githubUrl: githubCtl.text.trim(),
                liveUrl: liveCtl.text.trim(),
                playStoreUrl: '',
                category: categoryCtl.text.trim(),
                isFeatured: true,
                order: 1,
              );
              context.read<AdminBloc>().add(CreateProjectEvent(newProject));
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    final nameCtl = TextEditingController();
    final categoryCtl = TextEditingController(text: 'Mobile App');
    final proficiencyCtl = TextEditingController(text: '85');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Technical Skill'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  labelText: 'Skill Name (e.g. Flutter, Go)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: categoryCtl,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: proficiencyCtl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Proficiency (1-100%)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final skill = SkillEntity(
                id: 0,
                name: nameCtl.text.trim(),
                category: categoryCtl.text.trim(),
                iconUrl: '',
                proficiency: int.tryParse(proficiencyCtl.text.trim()) ?? 80,
                order: 1,
              );
              context.read<AdminBloc>().add(CreateSkillEvent(skill));
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    final roleCtl = TextEditingController();
    final compCtl = TextEditingController();
    final locCtl = TextEditingController();
    final startCtl = TextEditingController();
    final endCtl = TextEditingController(text: 'Present');
    final descCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Career Experience'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roleCtl,
                decoration: const InputDecoration(
                  labelText: 'Role / Job Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: compCtl,
                decoration: const InputDecoration(
                  labelText: 'Company / Organization',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: locCtl,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: startCtl,
                      decoration: const InputDecoration(
                        labelText: 'Start (e.g. 2023)',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: endCtl,
                      decoration: const InputDecoration(
                        labelText: 'End (e.g. Present)',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descCtl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final exp = ExperienceEntity(
                id: 0,
                role: roleCtl.text.trim(),
                company: compCtl.text.trim(),
                location: locCtl.text.trim(),
                startDate: startCtl.text.trim(),
                endDate: endCtl.text.trim(),
                isCurrent: endCtl.text.trim().toLowerCase() == 'present',
                description: descCtl.text.trim(),
                order: 1,
              );
              context.read<AdminBloc>().add(CreateExperienceEvent(exp));
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPassController = TextEditingController();
    final newPassController = TextEditingController();
    final confirmPassController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscureCurrent = true;
    bool obscureNew = true;
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.security_rounded, color: AppColors.primary),
              SizedBox(width: 10),
              Text(
                'Change Admin Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Update your admin credentials securely. You will need to sign in again after changing your password.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: currentPassController,
                      obscureText: obscureCurrent,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureCurrent
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                          ),
                          onPressed: () => setDialogState(
                            () => obscureCurrent = !obscureCurrent,
                          ),
                        ),
                      ),
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Current password is required'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: newPassController,
                      obscureText: obscureNew,
                      decoration: InputDecoration(
                        labelText: 'New Password (min 8 chars)',
                        prefixIcon: const Icon(Icons.vpn_key_outlined, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureNew
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                          ),
                          onPressed: () => setDialogState(
                            () => obscureNew = !obscureNew,
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'New password is required';
                        }
                        if (val.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (val == currentPassController.text) {
                          return 'New password must be different';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: confirmPassController,
                      obscureText: obscureNew,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                        prefixIcon: Icon(Icons.check_circle_outline, size: 20),
                      ),
                      validator: (val) {
                        if (val != newPassController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting ? null : () => Navigator.of(dialogCtx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isSubmitting
                  ? null
                  : () async {
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      setDialogState(() => isSubmitting = true);
                      try {
                        final apiClient = sl<ApiClient>();
                        await apiClient.post(
                          ApiEndpoints.changePassword,
                          data: {
                            'current_password': currentPassController.text,
                            'new_password': newPassController.text,
                          },
                        );
                        if (!context.mounted) return;
                        Navigator.of(dialogCtx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.success,
                            content: Text(
                              'Password updated successfully! Please sign in with your new password.',
                            ),
                          ),
                        );
                        context.read<AuthBloc>().add(LogoutRequestedEvent());
                        widget.onLogout();
                      } catch (e) {
                        setDialogState(() => isSubmitting = false);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.error,
                            content: Text(
                              'Failed to change password: ${e.toString().replaceAll("Exception:", "").trim()}',
                            ),
                          ),
                        );
                      }
                    },
              child: isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
