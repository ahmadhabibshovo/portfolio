import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';

class ContactSection extends StatefulWidget {
  final ProfileEntity profile;

  const ContactSection({super.key, required this.profile});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PortfolioBloc>().add(
        SubmitContactMessageEvent(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          subject: _subjectController.text.trim(),
          message: _messageController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return BlocListener<PortfolioBloc, PortfolioState>(
      listenWhen: (prev, curr) {
        if (prev is PortfolioLoaded && curr is PortfolioLoaded) {
          return prev.contactStatus != curr.contactStatus;
        }
        return false;
      },
      listener: (context, state) {
        if (state is PortfolioLoaded) {
          if (state.contactStatus == ContactSubmissionStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.success,
                content: Text(
                  state.contactFeedback ?? 'Message sent successfully!',
                ),
              ),
            );
            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
          } else if (state.contactStatus == ContactSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text(
                  state.contactFeedback ?? 'Failed to send message.',
                ),
              ),
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 64 : 24,
          vertical: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 36),
            Responsive(
              desktop: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildContactInfoCard()),
                  const SizedBox(width: 32),
                  Expanded(flex: 3, child: _buildFormCard()),
                ],
              ),
              mobile: Column(
                children: [
                  _buildContactInfoCard(),
                  const SizedBox(height: 24),
                  _buildFormCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LET\'S CONNECT',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Get In Touch With Ahmad',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Have a mobile project or idea?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'I am always open to discussing mobile architecture, full-time opportunities, freelance projects, or speaking engagements.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            _buildInfoTile(
              Icons.email_outlined,
              'Direct Email',
              widget.profile.email,
            ),
            const SizedBox(height: 16),
            _buildInfoTile(
              Icons.location_on_outlined,
              'Location',
              widget.profile.location,
            ),
            const SizedBox(height: 16),
            _buildInfoTile(
              Icons.code_rounded,
              'Focus',
              'Flutter, Android, Dart & Go APIs',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send a Direct Message',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  hintText: 'John Doe',
                  prefixIcon: Icon(Icons.person_outline, size: 20),
                ),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Name is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  hintText: 'john@example.com',
                  prefixIcon: Icon(Icons.mail_outline, size: 20),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!val.contains('@') || !val.contains('.')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  hintText: 'Mobile App Project Discussion',
                  prefixIcon: Icon(Icons.subject, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Your Message',
                  hintText: 'Hi Ahmad, let\'s discuss...',
                  alignLabelWithHint: true,
                ),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Message is required'
                    : null,
              ),
              const SizedBox(height: 24),
              BlocBuilder<PortfolioBloc, PortfolioState>(
                builder: (context, state) {
                  final isSubmitting =
                      state is PortfolioLoaded &&
                      state.contactStatus == ContactSubmissionStatus.submitting;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: isSubmitting ? null : _submit,
                      icon: isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF0F172A),
                              ),
                            )
                          : const Icon(Icons.send_rounded, size: 18),
                      label: Text(
                        isSubmitting ? 'Sending Message...' : 'Send Message',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
