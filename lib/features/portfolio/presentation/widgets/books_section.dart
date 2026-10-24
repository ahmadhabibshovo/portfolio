import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/book_entity.dart';

class BooksSection extends StatelessWidget {
  final List<BookEntity> books;

  const BooksSection({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) return const SizedBox.shrink();

    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'CONTINUOUS LEARNING',
            'Books & Engineering Foundations',
          ),
          const SizedBox(height: 12),
          const Text(
            'High-impact software engineering, architecture, and system design literature shaping my technical philosophy.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 260,
            ),
            itemBuilder: (context, index) {
              return _BookCard(book: books[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String tag, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _BookCard extends StatelessWidget {
  final BookEntity book;

  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image or Icon Placeholder
            Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.surfaceLight,
                border: Border.all(color: AppColors.cardBorder, width: 1),
              ),
              clipBehavior: Clip.antiAlias,
              child: book.coverUrl.isNotEmpty
                  ? Image.network(
                      book.coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildCoverPlaceholder(),
                    )
                  : _buildCoverPlaceholder(),
            ),
            const SizedBox(width: 16),

            // Book Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(book.status).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      book.status.toUpperCase(),
                      style: TextStyle(
                        color: _statusColor(book.status),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Author
                  Text(
                    'by ${book.author}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Star Rating
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < book.rating
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const Spacer(),

                  // Review / Read Action Link
                  if (book.linkUrl.isNotEmpty)
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () => _launch(book.linkUrl),
                      icon: const Icon(
                        Icons.open_in_new_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      label: const Text(
                        'Read / Details',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else if (book.review.isNotEmpty)
                    Text(
                      '"${book.review}"',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverPlaceholder() {
    return const Center(
      child: FaIcon(
        FontAwesomeIcons.bookOpen,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'currently reading':
        return AppColors.accent;
      case 'completed':
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
