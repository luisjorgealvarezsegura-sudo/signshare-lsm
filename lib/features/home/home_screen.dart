import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import 'home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                    child: _HeroHeader(isWide: isWide),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  sliver: SliverGrid.count(
                    crossAxisCount: isWide ? 2 : 1,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: isWide ? 2.6 : 2.7,
                    children: [
                      HomeCard(
                        key: const Key('search_word_card'),
                        title: AppStrings.search,
                        subtitle:
                            'Find every community sign video for a word like “hola”.',
                        icon: Icons.search_rounded,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.search,
                        ),
                      ),
                      HomeCard(
                        key: const Key('upload_sign_card'),
                        title: AppStrings.upload,
                        subtitle:
                            'Contribute a sign video with word and region details.',
                        icon: Icons.video_call_rounded,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.upload,
                        ),
                      ),
                     HomeCard(
                        key: const Key('recognize_sign_card'),
                        title: AppStrings.recognition,
                        subtitle:
                           'Compare a sign against examples',
                        icon: Icons.pan_tool_alt_rounded,
                        onTap: () {
                          Navigator.pushNamed(context, '/recognition');
                        },
                      ),
                      HomeCard(
                        key: const Key('about_project_card'),
                        title: AppStrings.about,
                        subtitle: 'Learn why community examples matter for LSM.',
                        icon: Icons.info_outline_rounded,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.about,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 36 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colorScheme.primary,
            child: Icon(
              Icons.diversity_3_rounded,
              color: colorScheme.onPrimary,
              size: 34,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            AppStrings.appName,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.tagline,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.appDescription,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _FeatureChip(label: 'LSM'),
              _FeatureChip(label: 'Community videos'),
              _FeatureChip(label: 'Recognition prototype'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: const Icon(Icons.check_circle_outline_rounded, size: 18),
    );
  }
}
