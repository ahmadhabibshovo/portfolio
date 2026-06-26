import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import '../constants/size.dart';
import '../constants/sns_links.dart';
import 'custom_text_field.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _submitForm() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: CustomColor.yellowPrimary,
        ),
      );
      return;
    }

    // Launch email client
    final String subject = 'Need Flutter Developer! - From $name';
    final String body = 'Name: $name\nEmail: $email\n\nMessage:\n$message';
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ahmadhabibshovo@gmail.com',
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 80),
      color: CustomColor.bgLight1.withValues(alpha: 0.3),
      child: Column(
        children: [
          // title
          const Text(
            "Get in touch",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: CustomColor.whitePrimary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          // Gradient underline
          Container(
            height: 3,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [
                  CustomColor.yellowSecondary,
                  CustomColor.yellowPrimary,
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),

          // Name and Email form
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= kMinDesktopWidth) {
                  return buildNameEmailFieldDesktop();
                }
                return buildNameEmailFieldMobile();
              },
            ),
          ),
          const SizedBox(height: 20),

          // Message field
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: CustomTextField(
              controller: _messageController,
              hintText: "Your message",
              maxLines: 8,
            ),
          ),
          const SizedBox(height: 25),

          // Submit Button
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  "Submit Form",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: Divider(color: Colors.white.withValues(alpha: 0.08)),
          ),
          const SizedBox(height: 25),

          // Social icons with hover scaling
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _SocialIcon(
                asset: "assets/github.png",
                onTap: () => _launchURL(SnsLinks.github),
              ),
              _SocialIcon(
                asset: "assets/linkedin.png",
                onTap: () => _launchURL(SnsLinks.linkedIn),
              ),
              _SocialIcon(
                asset: "assets/facebook.png",
                onTap: () => _launchURL(SnsLinks.facebook),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildNameEmailFieldDesktop() {
    return Row(
      children: [
        Flexible(
          child: CustomTextField(
            controller: _nameController,
            hintText: "Your name",
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: CustomTextField(
            controller: _emailController,
            hintText: "Your email",
          ),
        ),
      ],
    );
  }

  Widget buildNameEmailFieldMobile() {
    return Column(
      children: [
        CustomTextField(
          controller: _nameController,
          hintText: "Your name",
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _emailController,
          hintText: "Your email",
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({required this.asset, required this.onTap});
  final String asset;
  final VoidCallback onTap;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered
                  ? CustomColor.yellowSecondary.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                color: _isHovered
                    ? CustomColor.yellowSecondary.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Image.asset(
              widget.asset,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
