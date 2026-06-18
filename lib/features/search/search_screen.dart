import 'package:flutter/material.dart';

import '../../models/sign_video.dart';
import '../../services/sign_upload_service.dart';
import 'sign_video_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<SignVideo>> _signsFuture;

  String query = '';

  @override
  void initState() {
    super.initState();
    _signsFuture = SignUploadService.searchSigns('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String value) {
    final q = value.trim().toLowerCase();

    setState(() {
      query = q;
      _signsFuture = SignUploadService.searchSigns(q);
    });
  }

  void _refreshSigns() {
    setState(() {
      _signsFuture = SignUploadService.searchSigns(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a Word'),
        actions: [
          IconButton(
            tooltip: 'Refresh signs',
            onPressed: _refreshSigns,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<SignVideo>>(
        future: _signsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final signs = snapshot.data ?? [];

          return _SearchContent(
            signs: signs,
            searchController: _searchController,
            onQueryChanged: _search,
          );
        },
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent({
    required this.signs,
    required this.searchController,
    required this.onQueryChanged,
  });

  final List<SignVideo> signs;
  final TextEditingController searchController;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    final groupedResults = <String, List<SignVideo>>{};

    for (final sign in signs) {
      final groupKey =
          sign.wordKey.isEmpty ? sign.word.toLowerCase() : sign.wordKey;

      groupedResults.putIfAbsent(groupKey, () => <SignVideo>[]);
      groupedResults[groupKey]!.add(sign);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search a word...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: onQueryChanged,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: groupedResults.isEmpty
                ? const Center(
                    child: Text('No signs found.'),
                  )
                : ListView(
                    children: groupedResults.entries.map((entry) {
                      final videos = entry.value;
                      final word = videos.first.word;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                word,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${videos.length} community sign variation(s)',
                              ),
                              const SizedBox(height: 12),
                              ...videos.map(
                                (video) =>
                                    SignVideoTile(video: video),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}