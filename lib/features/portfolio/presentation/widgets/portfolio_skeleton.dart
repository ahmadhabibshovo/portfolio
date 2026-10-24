import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_shimmer.dart';

/// High-fidelity full-page skeleton that mirrors the real portfolio layout
class PortfolioSkeleton extends StatelessWidget {
  const PortfolioSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AppShimmer(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // 1. Navbar Skeleton
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.surface, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ShimmerBox(width: 140, height: 28, borderRadius: 6),
                    if (isDesktop)
                      Row(
                        children: List.generate(
                          6,
                          (index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ShimmerBox(
                              width: 65,
                              height: 18,
                              borderRadius: 4,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // 2. Hero Section Skeleton
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 64 : 24,
                  vertical: 60,
                ),
                child: isDesktop
                    ? const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: _HeroTextSkeleton()),
                          SizedBox(width: 48),
                          ShimmerCircle(size: 260),
                        ],
                      )
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShimmerCircle(size: 200),
                          SizedBox(height: 32),
                          _HeroTextSkeleton(isCentered: true),
                        ],
                      ),
              ),

              const SizedBox(height: 30),

              // 3. Highlights Section Skeleton
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 64 : 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerBox(width: 200, height: 32, borderRadius: 6),
                    const SizedBox(height: 24),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 4 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: isDesktop ? 1.4 : 1.1,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(width: 40, height: 40, borderRadius: 8),
                            Spacer(),
                            ShimmerBox(width: 120, height: 16, borderRadius: 4),
                            SizedBox(height: 8),
                            ShimmerBox(width: 80, height: 12, borderRadius: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // 4. Projects Section Skeleton
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 64 : 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerBox(width: 180, height: 32, borderRadius: 6),
                    const SizedBox(height: 24),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: isDesktop ? 0.95 : 1.2,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ShimmerBox(
                                height: double.infinity,
                                borderRadius: 16,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerBox(
                                      width: 160,
                                      height: 18,
                                      borderRadius: 4,
                                    ),
                                    SizedBox(height: 10),
                                    ShimmerBox(
                                      width: double.infinity,
                                      height: 12,
                                      borderRadius: 4,
                                    ),
                                    SizedBox(height: 6),
                                    ShimmerBox(
                                      width: 200,
                                      height: 12,
                                      borderRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroTextSkeleton extends StatelessWidget {
  final bool isCentered;

  const _HeroTextSkeleton({this.isCentered = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const ShimmerBox(width: 240, height: 32, borderRadius: 20),
        const SizedBox(height: 20),
        const ShimmerBox(width: 120, height: 18, borderRadius: 4),
        const SizedBox(height: 12),
        const ShimmerBox(width: 320, height: 48, borderRadius: 8),
        const SizedBox(height: 14),
        const ShimmerBox(width: 280, height: 24, borderRadius: 6),
        const SizedBox(height: 18),
        const ShimmerBox(width: double.infinity, height: 14, borderRadius: 4),
        const SizedBox(height: 8),
        const ShimmerBox(width: 380, height: 14, borderRadius: 4),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment:
              isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: const [
            ShimmerBox(width: 140, height: 46, borderRadius: 24),
            SizedBox(width: 16),
            ShimmerBox(width: 140, height: 46, borderRadius: 24),
          ],
        ),
      ],
    );
  }
}
