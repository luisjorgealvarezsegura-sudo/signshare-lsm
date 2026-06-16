import 'package:flutter/material.dart';

import '../../models/sign_video.dart';
import 'demo_sign_repository.dart';
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
    _signsFuture = _loadAllSigns();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<SignVideo>> _loadAllSigns() async {
  return DemoSignRepository.signs;
}

  void _refreshSigns() {
    setState(() {
      _signsFuture = _loadAllSigns();
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

          final signs = snapshot.data ?? const <SignVideo>[];

          return _SearchContent(
            signs: signs,
            query: query,
            searchController: _searchController,
            onQueryChanged: (value) {
              setState(() {
                query = value.trim().toLowerCase();
              });
            },
          );
        },
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent({
    required this.signs,
    required this.query,
    required this.searchController,
    required this.onQueryChanged,
  });

  final List<SignVideo> signs;
  final String query;
  final TextEditingController searchController;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    final filteredSigns = query.isEmpty
        ? signs
        : signs.where((sign) => sign.wordKey.contains(query)).toList();

    final groupedResults = <String, List<SignVideo>>{};

    for (final sign in filteredSigns) {
      final groupKey = sign.wordKey.isEmpty ? sign.word.toLowerCase() : sign.wordKey;

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                word,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${videos.length} community sign variation(s)',
                              ),
                              const SizedBox(height: 12),
                              ...videos.map(
                                (video) => SignVideoTile(video: video),
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