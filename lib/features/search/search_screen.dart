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
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = DemoSignRepository.signs.where((sign) {
      return sign.wordKey.contains(
        query.toLowerCase(),
      );
    }).toList();

    final groupedResults = <String, List<SignVideo>>{};

    for (final sign in results) {
      groupedResults.putIfAbsent(sign.word, () => []);
      groupedResults[sign.word]!.add(sign);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a Word'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search a word...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.trim();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: groupedResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No signs found.',
                      ),
                    )
                  : ListView(
                      children: groupedResults.entries.map((entry) {
                        final word = entry.key;
                        final videos = entry.value;

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
                                  (video) => SignVideoTile(
                                    video: video,
                                  ),
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
      ),
    );
  }
}