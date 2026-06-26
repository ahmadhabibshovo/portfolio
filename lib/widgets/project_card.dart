import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../utils/project_utils.dart';

class ProjectCardWidget extends StatefulWidget {
  const ProjectCardWidget({
    super.key,
    required this.project,
  });

  final ProjectUtils project;

  @override
  State<ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<ProjectCardWidget> {
  bool _isHovered = false;

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Ignored for safety
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          clipBehavior: Clip.antiAlias,
          height: 300,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CustomColor.bgLight2.withValues(alpha: 0.5),
            border: Border.all(
              color: _isHovered
                  ? CustomColor.yellowSecondary.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? CustomColor.yellowSecondary.withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.1),
                blurRadius: _isHovered ? 25 : 12,
                offset: _isHovered ? const Offset(0, 10) : const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // project img
              SizedBox(
                height: 140,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: AnimatedScale(
                      scale: _isHovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 250),
                      child: Image.asset(
                        widget.project.image,
                        height: 140,
                        width: 270,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // title
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
                child: Text(
                  widget.project.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: CustomColor.whitePrimary,
                  ),
                ),
              ),
              // subtitle
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                child: Text(
                  widget.project.subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CustomColor.whiteSecondary,
                    height: 1.3,
                  ),
                ),
              ),
              const Spacer(),
              // footer
              Container(
                color: CustomColor.bgLight1.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    const Text(
                      "Available on:",
                      style: TextStyle(
                        color: CustomColor.yellowSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    if (widget.project.iosLink != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () => _launchURL(widget.project.iosLink!),
                          child: Image.asset(
                            "assets/ios_icon.png",
                            width: 18,
                          ),
                        ),
                      ),
                    if (widget.project.androidLink != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () => _launchURL(widget.project.androidLink!),
                          child: Image.asset(
                            "assets/android_icon.png",
                            width: 17,
                          ),
                        ),
                      ),
                    if (widget.project.githubLink != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () => _launchURL(widget.project.githubLink!),
                          child: Image.asset(
                            "assets/github.png",
                            width: 17,
                          ),
                        ),
                      ),
                    if (widget.project.webLink != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () => _launchURL(widget.project.webLink!),
                          child: Image.asset(
                            "assets/web_icon.png",
                            width: 17,
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
