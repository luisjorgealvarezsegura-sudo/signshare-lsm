import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('About the Project')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Icon(
              Icons.diversity_3_rounded,
              size: 72,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Community-powered sign sharing',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'SignShare LSM helps people collect and share different ways of signing the same word. A word like “hola” can have several video examples because signs may vary by region, school, family, or signer.',
              style: textTheme.bodyLarge?.copyWith(height: 1.45),
            ),
            const SizedBox(height: 22),
            const _InfoTile(
              icon: Icons.search_rounded,
              title: 'Search',
              text:
                  'Users search a word and view every uploaded video connected to that word.',
            ),
            const _InfoTile(
              icon: Icons.video_call_rounded,
              title: 'Upload',
              text:
                  'Users contribute a short sign video with word, country, region, and language information.',
            ),
            const _InfoTile(
              icon: Icons.pan_tool_alt_rounded,
              title: 'Recognize',
              text:
                  'The future prototype will compare recorded signs against approved community examples and return the closest matches.',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(text),
      ),
    );
  }
}
